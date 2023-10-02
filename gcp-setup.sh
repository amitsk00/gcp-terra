#! /usr/bin/bash


NL="\n"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
NC="\e[1;0m"

LINE_SEP="\n\n"
PREFIX=" >>> "






echo -e "${BLUE}Starting GCP setup ${NC}" 
echo "-----------------------------------------"


USER=$(gcloud config list --format="value(core.account)")

PROJECT="ask-proj-25"
ACCOUNT="cicd-terra"
DESCR="CICD account using Terraform for IaC"
SA_EMAIL="${ACCOUNT}@${PROJECT}.iam.gserviceaccount.com"
export CICD_TERRA_SA=${SA_EMAIL}
DISPLAY_NAME="CICD for Terraform"


if [[ -f ./params.sh ]]; then
    echo -e "params file is present"
    source ./params.sh
    envsubst < terraform-template.tfvars > terraform.tfvars
else 
    echo -e "params file is missig - create the file and run again"
    exit 25
fi 



ROLES=(
  "iam.serviceAccountUser"
  "iam.serviceAccountTokenCreator"
)

temp1=$(gcloud iam service-accounts list --filter="email:cicd"  --format="value(email)")
if [[ "${temp1}" == "${SA_EMAIL}" ]]
then
    echo -e "${PREFIX}${YELLOW}SA ${SA_EMAIL} already created ${NC} "
else
    echo -e "${PREFIX}${BLUE}SA ${SA_EMAIL} to be created ${NC} "

    gcloud iam service-accounts create ${ACCOUNT} \
        --project=${PROJECT} \
        --display-name="${DISPLAY_NAME}" \
        --description="${DESCR}"

fi         

gcloud projects add-iam-policy-binding ${PROJECT} \
    --project=${PROJECT} \
    --member=serviceAccount:${SA_EMAIL} \
    --role=roles/owner >/dev/null 


 
MYDIR=$(dirname "$0")
# Use sparingly 
if [[ -f "${MYDIR}/key.json" ]]
then 
    echo -e "${PREFIX}${YELLOW}Skipping key creation ... ${NC}"
else 
    echo -e "${PREFIX}${YELLOW}SA key being created ... ${NC}"
    gcloud iam service-accounts keys create ${MYDIR}/key.json \
        --project=${PROJECT} \
        --iam-account=${SA_EMAIL} 
fi 


# create main bucket 

GCS_MAIN="${PROJECT}-main"
GCS_MAIN="gs://${GCS_MAIN}"
gcloud storage buckets describe ${GCS_MAIN} >/dev/null 2>&1
retGcs=$?

if [[ "${retGcs}" -eq  "0"  ]]
then
    echo -e "${PREFIX}${YELLOW}Main/default Bucket exists${NC}"
else
    echo -e "${PREFIX}${RED}Main/default Bucket doesn't exist, will be created now${NC}"
    gcloud storage buckets create ${GCS_MAIN}
fi 

# # Adding SA access to amit

# for ROLE in ${ROLES[@]}
# do
#     echo -e "Assigning ${ROLE} to ${USER} on ${SA_EMAIL} " 
#     gcloud iam service-accounts add-iam-policy-binding ${SA_EMAIL} \
#         --member=user:${USER} \
#         --role=roles/${ROLE} \
#         --project=${PROJECT} >/dev/null
# done






# Set SA for Terraform
export GOOGLE_IMPERSONATE_SERVICE_ACCOUNT=${SA_EMAIL}



echo -e "${LINE_SEP}Setting up terraform "
terraform init

SUCCESS="0"

echo -e "${PREFIX}getting the plan ..."
terraform plan  --var-file=terraform.tfvars  --out=my_terra_plan 
retCdPlan="$?"

if [[ "${retCdPlan}" -gt "0" ]]
then
    echo -e "${RED}Terraform Plan returned errors, correct them first to proceed ahead  ${NC}"
else
    echo -e "${LINE_SEP}"
    read -p "Do you want to proceed as per above plan? (yes/no) - " myReply
    
    if [[ "$myReply" == "yes" ]]
    then 
        echo -e "setting up infra"

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
fi



