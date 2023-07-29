#! /usr/bin/bash


NL="\n"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
NC="\e[1;0m"


echo -e "starting GCP setup" 
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
    echo -e "${RED} SA ${SA_EMAIL} already created ${NC} "
else
    echo -e "${GREEN} SA ${SA_EMAIL} to be created ${NC} "
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

 

# Use sparingly 
if [[ -f "./key.json" ]]
then 
    echo -e "Skipping key creation ..."
else 
    gcloud iam service-accounts keys create ${PWD}/key.json \
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


# export GOOGLE_IMPERSONATE_SERVICE_ACCOUNT=${SA_EMAIL}



echo -e "setting up terraform "
terraform init


echo -e "getting the plan ..."
terraform plan  --var-file=terraform.tfvars 


echo -e "setting up infra"
terraform apply  --var-file=terraform.tfvars 

