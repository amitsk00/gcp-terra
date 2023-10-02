#! /usr/bin/bash


NL="\n"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
NC="\e[1;0m"


PROJECT="ask-proj-25"
ACCOUNT="cicd-terra"
SA_EMAIL="${ACCOUNT}@${PROJECT}.iam.gserviceaccount.com"
export CICD_TERRA_SA=${SA_EMAIL}

if [[ -f ./params.sh ]]; then
    echo -e "params file is present"
    source ./params.sh
    envsubst < terraform-template.tfvars > terraform.tfvars
else 
    echo -e "params file is missig - create the file and run again"
    exit 25
fi 



echo -e "wiping off GCP setup" 
echo "-----------------------------------------"



echo -e "setting up terraform "
terraform init


echo -e "cleaning up all infra  ..."
terraform destroy 

if [[ "$?" -eq "0" ]]; then
    echo -e "${GREEN} *** Waiting for 15 seconds so that all resources would be ready (or rather, destroyed) *** ${NC}"
    sleep 15
fi 

