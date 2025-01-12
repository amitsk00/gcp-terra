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


export USER=$(gcloud config list --format="value(core.account)")


if [[ -f ../params.sh ]]; then
    echo -e "params file is present and will be sourced now"
    source ../params.sh
    envsubst < terraform-template.tfvars > terraform.tfvars
else 
    echo -e "params file is missig - create the file and run again"
    exit 25
fi 

CURR_USER=$(gcloud config list --format="value(core.account)")
if [[ ${USER} != ${CURR_USER} ]]
then
    echo -e "${RED}User doesn't match, please login (gcloud config) with correct user ${NC}"
    echo -e "${BLUE}Current user (gcloud config) is \"${CURR_USER}\" and expected user is \"${USER}\" ${NC}"
    exit 15
fi

CURR_PROJECT=$(gcloud config list --format="value(core.project)")
if [[ ${PROJECT_ID} != ${CURR_PROJECT} ]]
then
    echo -e "${RED}Project doesn't match, please login (gcloud config) with correct project ${NC}"
    echo -e "${BLUE}Current project (gcloud config) is \"${CURR_PROJECT}\" and expected project is \"${PROJECT_ID}\" ${NC}"
    exit 16
fi



PROJECT=${PROJECT_ID}
ACCOUNT=${CICD_TERRA_SA}
CICD_EMAIL="${ACCOUNT}@${PROJECT}.iam.gserviceaccount.com"
export CICD_TERRA_SA=${CICD_EMAIL}




# echo -e "${PREFIX}${BLUE}Wiping off GCP setup ${NC}" 

# Set SA for Terraform
export GOOGLE_IMPERSONATE_SERVICE_ACCOUNT=${CICD_EMAIL}

echo "-----------------------------------------"
echo -e "${PREFIX}${BLUE}setting up terraform "
terraform init

echo -e "${LINE_SEP}${BLUE}List of existing infra as below: ${YELLOW}"
echo -e "==================================================="
terraform state list 
echo -e "===================================================${NC}${LINE_SEP}"



echo -e "${PREFIX}${BLUE}cleaning up all infra  ..."
terraform destroy  -auto-approve

if [[ "$?" -eq "0" ]]; then
    echo -e "${GREEN} *** Waiting for 15 seconds so that all resources would be ready (or rather, destroyed) *** ${NC}"
    sleep 15
fi 

