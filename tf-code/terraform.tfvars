project_id                 = "ask-proj-35"
# credentials_file         = "<FILE>"
main_user               = "amitsk.gcp.35@gmail.com"

region                  = "us-central1"
zone                    = "us-central1-c"

terra_backend_gcs       = "gs://ask-proj-35-terraform/"
terra_backend_prefix    = "state"

cicd_terra              = "cicd-terra"
sa_core_viewer          = "gcp-core-viewer"
sa_list                 = [
                        "test1234"  ,
                        "test-run" ,
                        "test-vm" 
                        ]


# Count and enabling if more than 0
count_zonal_mig  = 1
count_regional_mig = 0
create_run = false
create_gke = false



## GCS
first_suffix            = "xyz"
gcs_loc_us              = "US"


# AR
py_image_1          = "py-v1"

# VPC
vpc_name                = "my-new-network1"
cidr1                   = "10.1.0.0/16"

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
mac_type_e2m            = "e2-medium"
mac_type_f1m            = "f1-micro"
vm_name                 = "test123"
vm_image                = "debian-cloud/debian-11"
startup_url             = "gs://ask-proj-35-main/rhel_startup.sh"
metadata_vm             = [ ]


# MIG
autoscaling = true
max_replicas = 4
min_replicas = 2
cooldown_period = 45
autoscaling_cpu = 0.6


