project_id                 = "ask-proj-25"
# credentials_file         = "<FILE>"


region                  = "us-central1"
zone                    = "us-central1-c"


sa_core_viewer          = "gcp-25-core-viewer"
sa_list                 = [
                        "test1234"  ,
                        "test-run" ,
                        "test-vm" 
                        ]



## GCS
first_suffix            = "xyz"
gcs_loc_us              = "US"


# VPC
cidr1                   = "10.1.1.0/24"

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


autoscaling = false
max_replicas = 3
min_replicas = 2
cooldown_period = 45
autoscaling_cpu = 0.6


