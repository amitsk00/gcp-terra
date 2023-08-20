#! /usr/bin/bash


NL="\n"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
NC="\e[1;0m"


echo -e "${BLUE}Starting GCP setup ${NC}" 
echo "-----------------------------------------"
# gcloud config list 
# echo "-----------------------------------------"



USER=$(gcloud config list --format="value(core.account)")

PROJECT="ask-proj-25"
ACCOUNT="cicd-terra"
DESCR="CICD account using Terraform for IaC"
SA_EMAIL="${ACCOUNT}@${PROJECT}.iam.gserviceaccount.com"
DISPLAY_NAME="CICD for Terraform"

ROLES=(
  "iam.serviceAccountUser"
  "iam.serviceAccountTokenCreator"
)

temp1=$(gcloud iam service-accounts list --filter="email:cicd"  --format="value(email)")
if [[ "${temp1}" == "${SA_EMAIL}" ]]
then
    echo -e "${YELLOW}  SA ${SA_EMAIL} already created ${NC} "
else
    echo -e "${BLUE}    SA ${SA_EMAIL} to be created ${NC} "
    set -x

    gcloud iam service-accounts create ${ACCOUNT} \
        --project=${PROJECT} \
        --display-name="${DISPLAY_NAME}" \
        --description="${DESCR}"

    gcloud projects add-iam-policy-binding ${PROJECT} \
        --project=${PROJECT} \
        --member=serviceAccount:${SA_EMAIL} \
        --role=roles/owner 

    set +x 
fi         

 
MYDIR=$(dirname "$0")
# Use sparingly 
if [[ -f "${MYDIR}/key.json" ]]
then 
    echo -e "${YELLOW}  Skipping key creation ..."
else 
    echo -e "${YELLOW}  key being created ... ${NC}"
    gcloud iam service-accounts keys create ${MYDIR}/key.json \
        --project=${PROJECT} \
        --iam-account=${SA_EMAIL}
fi 

# for ROLE in ${ROLES[@]}
# do
#     echo -e "Assigning ${ROLE} to ${USER} on ${SA_EMAIL} " 
#     gcloud iam service-accounts add-iam-policy-binding ${SA_EMAIL} \
#         --member=user:${USER} \
#         --role=roles/${ROLE} \
#         --project=${PROJECT}
# done


export GOOGLE_IMPERSONATE_SERVICE_ACCOUNT=${SA_EMAIL}



echo -e "\n\nSetting up terraform "
terraform init

SUCCESS="0"

echo -e "getting the plan ..."
terraform plan  --var-file=terraform.tfvars  --out=my_terra_plan 


cdPlan="$?"
echo -e ${cdPlan}
if [[ "${cdPlan}" -gt "0" ]]
then
    echo -e "${RED}Terraform Plan returned errors, correct them first to proceed ahead  ${NC}"
else
    echo -e "setting up infra"
    terraform apply  --var-file=terraform.tfvars 
    if [[ "${?}" -gt "0" ]]
    then
        echo -e "${RED}Terraform Apply returned errors  ${NC}"

    else
        echo -e "${GREEN} GCP Infra setup completed successfully ${NC}" 
        SUCCESS="1"
    fi
    
fi 

if [[ "${SUCCESS}" -eq "1"  ]]
then
    echo -e "${GREEN} **** Waiting for 15 seconds so that all resources would be ready *** ${NC}"
    sleep 15
fi



