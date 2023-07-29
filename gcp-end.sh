#! /usr/bin/bash


NL="\n"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
NC="\e[1;0m"


echo -e "wiping off GCP setup" 
echo "-----------------------------------------"



echo -e "setting up terraform "
terraform init


echo -e "cleaning up all infra  ..."
terraform destroy 

