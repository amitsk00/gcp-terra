project_id                 = "${PROJECT_ID}"
# credentials_file         = "<FILE>"
main_user               = "${USER}"

region                  = "${REGION}"
zone                    = "${ZONE}"

terra_backend_gcs       = "${GCS_TERRA}/"
terra_backend_prefix    = "state"

cicd_terra              = "${CICD_TERRA_SA}"
sa_core_viewer          = "${CORE_VIEWER}"
sa_list                 = [
                        "test1234"  ,
                        "test-run" ,
                        "test-vm" 
                        ]



## GCS
first_suffix            = "${FIRST_BUCKET}"
gcs_loc_us              = "${GCS_LOC_US}"


# VPC
cidr1                   = "${CIDR1}"

subnet_map = {
    "sub1" = {
        name = "subnet01"
        cidr = "10.2.1.0/24"
        region = "us-central1"
        }
    "sub2" = {
        name = "subnet02"
        cidr = "10.2.2.0/24"
        region = "us-east4"
        }
}



# VM
mac_type_e2m            = "${MACHINE_TYPE_e2m}"
mac_type_f1m            = "${MACHINE_TYPE_f1m}"
vm_name                 = "${VM_NAME}"
vm_image                = "${VM_IMAGE}"
startup_url             = "${GCS_STARTUP_URL}"


# MIG
autoscaling = ${AUTOSCALE}
max_replicas = ${MAX_REPLICA}
min_replicas = ${MIN_REPLICA}
cooldown_period = ${COOLDOWN}
autoscaling_cpu = ${AUTOSCALE_CPU}


