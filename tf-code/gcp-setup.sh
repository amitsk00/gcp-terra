#! /usr/bin/bash

set -e 

NL="\n"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
NC="\e[1;0m"

LINE_SEP="\n\n"
PREFIX=" >>> "



echo -e "${LINE_SEP}${BLUE}Starting GCP setup ${NC}" 
echo "-----------------------------------------"

if [[ -f ../params.sh ]]; then
    echo -e "params file is present and will be sourced now"
    source ../params.sh
    envsubst < terraform-template.tfvars > terraform.tfvars
else 
    echo -e "${RED}params file is missig - create the file and run again ${NC}"
    exit 10
fi 



CURR_USER=$(gcloud config list --format="value(core.account)")
if [[ ${USER} != ${CURR_USER} ]]
then
    
    echo -e "${BLUE}Current user (gcloud config) is \"${CURR_USER}\" and expected user is \"${USER}\" ${NC}"
    echo -e "${RED}User doesn't match, please login (gcloud config) with correct user ${NC}"
    exit 15
fi

CURR_PROJECT=$(gcloud config list --format="value(core.project)")
if [[ ${PROJECT_ID} != ${CURR_PROJECT} ]]
then
    
    echo -e "${BLUE}Current project (gcloud config) is \"${CURR_PROJECT}\" and expected project is \"${PROJECT_ID}\" ${NC}"
    echo -e "${RED}Project doesn't match, please login (gcloud config) with correct project ${NC}"
    exit 16
fi

echo -e "user and project set properly"


PROJECT=${PROJECT_ID}
ACCOUNT=${CICD_TERRA_SA}
DESCR="CICD account using Terraform for IaC"
CICD_EMAIL="${ACCOUNT}@${PROJECT}.iam.gserviceaccount.com"
export CICD_TERRA_SA=${CICD_EMAIL}
DISPLAY_NAME="CICD for Terraform"




ROLES=(
  "iam.serviceAccountUser"
  "iam.serviceAccountTokenCreator"
)


function define-sa-with-binding() {

    ###################
    # Check if CICD SA exists, create if missing
    temp1=$(gcloud iam service-accounts list --filter="email:cicd"  --format="value(email)")

    echo -e "${LINE_SEP}" 
    if [[ "${temp1}" == "${CICD_EMAIL}" ]]
    then
        echo -e "${PREFIX}${YELLOW}SA ${CICD_EMAIL} already created ${NC} "
    else
        echo -e "${PREFIX}${BLUE}SA ${CICD_EMAIL} to be created ${NC} "

        gcloud iam service-accounts create ${ACCOUNT} \
            --project=${PROJECT} \
            --display-name="${DISPLAY_NAME}" \
            --description="${DESCR}"

    fi         

    # XXXX
    # Check if we really need Owner permission on SA
    gcloud projects add-iam-policy-binding ${PROJECT} \
        --project=${PROJECT} \
        --member=serviceAccount:${CICD_EMAIL} \
        --role=roles/owner >/dev/null 


    # Adding SA access to amit
    for ROLE in ${ROLES[@]}
    do
        echo -e "${BLUE}Assigning ${ROLE} to ${USER} on ${CICD_EMAIL}  ${NC}" 
        gcloud iam service-accounts add-iam-policy-binding ${CICD_EMAIL} \
            --member=user:${USER} \
            --role=roles/${ROLE} \
            --project=${PROJECT} >/dev/null
    done


    ################
    # key file for SA  in parent folder
    MYDIR=$(dirname "$0")
    MYDIR="${MYDIR}/../"

    # Use sparingly 
    # create key file for CICD SA
    if [[ -f "${MYDIR}/key.json" ]]
    then 
        echo -e "${PREFIX}${BLUE}Skipping key creation ... ${NC}"
    else 
        echo -e "${PREFIX}${YELLOW}SA key being created ... ${NC}"
        gcloud iam service-accounts keys create ${MYDIR}/key.json \
            --project=${PROJECT} \
            --iam-account=${CICD_EMAIL} 
    fi 


}



function create-first-bucket() {
    echo -e "${LINE_SEP}" 

    # create main bucket if missing
    set +e
    gcloud storage buckets describe ${GCS_MAIN} >/dev/null 2>&1
    retGcs=$?
    set -e

    if [[ "${retGcs}" -eq  "0"  ]]
    then
        echo -e "${PREFIX}${YELLOW}Main/default Bucket exists${NC}"
    else
        echo -e "${PREFIX}${BLUE}Main/default Bucket doesn't exist, will be created now${NC}"
        gcloud storage buckets create ${GCS_MAIN}
    fi 
    gcloud storage cp "../${STARTUP_FILE}" "${GCS_MAIN}/${STARTUP_FILE}"
    gcloud storage cp ../py-files/load_generator.py "${GCS_MAIN}/load_generator.py"
    gcloud storage cp ../py-files/py_load.service "${GCS_MAIN}/py_load.service"


    # create bucket for terraform files
    set +e
    gcloud storage buckets describe ${GCS_TERRA} >/dev/null 2>&1
    retGcs=$?
    set -e

    if [[ "${retGcs}" -eq  "0"  ]]
    then
        echo -e "${PREFIX}${YELLOW}Terraform related Bucket exists${NC}"
    else
        echo -e "${PREFIX}${BLUE}Terraform related Bucket doesn't exist, will be created now${NC}"
        gcloud storage buckets create ${GCS_TERRA}
    fi 

}


if [[ "${isDayZero}" == "true" ]]; then 
    define-sa-with-binding
    create-first-bucket
fi 


# enable required APIs before starting terraform
gcloud services enable cloudresourcemanager.googleapis.com



# Set SA for Terraform
export GOOGLE_IMPERSONATE_SERVICE_ACCOUNT=${CICD_EMAIL}



echo -e "${LINE_SEP}${BLUE}Setting up terraform ${NC}"

# # below lines to set backend as GCS using variables
# export TF_VAR_terra_backend_gcs="${GCS_TERRA}/"
# export TF_VAR_terra_backend_prefix="state"
# terraform init \
#   -backend-config="bucket=${TF_VAR_terra_backend_gcs}" \
#   -backend-config="prefix=${TF_VAR_terra_backend_prefix}"

terraform init -upgrade 




echo -e "${LINE_SEP}${BLUE}List of existing infra as below: ${YELLOW}"
echo -e "==================================================="
terraform state list 
echo -e "===================================================${NC}${LINE_SEP}"


SUCCESS="0"

echo -e "${PREFIX} ${BLUE}getting the plan ... ${NC}"
terraform plan  --var-file=terraform.tfvars  --out=my_terra_plan 
# terraform plan  --var-file=terraform.tfvars  --out=my_terra_plan  | grep -E 'Plan:|will be|must be'
retCdPlan="$?"

if [[ "${retCdPlan}" -gt "0" ]]
then
    echo -e "${RED}Terraform Plan returned errors, correct them first to proceed ahead  ${NC}"
else
    echo -e "${LINE_SEP}"
    read -p "Do you want to proceed as per above plan? (yes/no) - " myReply
    
    if [[ "$myReply" == "yes" ]]
    then 
        echo -e "${LINE_SEP}${BLUE}setting up infra${NC}"

        terraform apply  my_terra_plan 
        if [[ "${?}" -gt "0" ]]
        then
            echo -e "${RED}Terraform Apply returned errors  ${NC}"

        else
            echo -e "${GREEN} GCP Infra setup completed successfully ${NC}" 
            SUCCESS="1"
        fi
    else 
        echo -e "${BLUE}Cancelled by user input ..."
    fi 
    
fi 

if [[ "${SUCCESS}" -eq "1"  ]]
then
    echo -e "${LINE_SEP}${GREEN} **** Waiting for 15 seconds so that all resources would be ready *** ${NC}"
    sleep 15

    ################
    # below code to setup AR
    py_repo=$(terraform output -raw ar_repo_url)
    py_repo_url="${REGION}-docker.pkg.dev/${PROJECT_ID}/${py_repo}"

    gcloud auth configure-docker

    set -x
    gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin "https://${REGION}-docker.pkg.dev"
    sudo docker push ${py_repo_url}/${PY_IMAGE_1}:latest
    set +x


    # # Get the Load Balancer IP address
    # LB_IP=$(terraform output -raw lb_ip)
    # # Send load to the Load Balancer
    # ab -n 100000 -c 100 http://$LB_IP/

fi



##########
# to unlock terra lock file
# terraform force-unlock 1735645114520001