

# change project and gmail ID for new ID
export PROJECT_ID="ask-proj-35"
export PROJECT_NUMBER=$(gcloud projects describe  ${PROJECT_ID} --format="value(projectNumber)" )
export USER="amitsk.gcp.35@gmail.com"


# Generic
export isDayZero=false

# GCP Generic 
export REGION="us-central1"
export ZONE="us-central1-c"

export CORE_VIEWER="gcp-core-viewer"
export CICD_TERRA_SA="cicd-terra"


# GCS
GCS_MAIN="${PROJECT_ID}-main"
GCS_MAIN="gs://${GCS_MAIN}"
export GCS_MAIN

GCS_TERRA="gs://${PROJECT_ID}-terraform"
export GCS_TERRA

export FIRST_BUCKET="xyz"
export GCS_LOC_US=US


# VPC
export CIDR1="10.1.0.0/16"



# GCE VM
export MACHINE_TYPE_e2m="e2-medium"
export MACHINE_TYPE_f1m="f1-micro"
export VM_NAME="test123"
export VM_IMAGE="debian-cloud/debian-11"
export STARTUP_FILE="rhel_startup.sh"
export GCS_STARTUP_URL="${GCS_MAIN}/${STARTUP_FILE}"


export MAX_REPLICA=3
export MIN_REPLICA=2
export COOLDOWN=45
export AUTOSCALE_CPU=0.6
export AUTOSCALE=false
