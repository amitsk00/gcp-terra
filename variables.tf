
variable module_enabled {
  description = ""
  default     = true
}


variable "project_id" { }

variable "credentials_file" { 
    default = "key.json"
}

variable "region" {
    type = string
    description = " Region name"
    default = "us-central1"
}

variable "zone" {
    type = string
    description = "Zone name"
    default = "us-central1-c"
}








variable "service_list" {
    type = list(string)
    default = [
      "storage.googleapis.com",
    #   "storage-api.googleapis.com",
    #   "storage-component.googleapis.com" ,

    #   "container.googleapis.com" ,
    #   "containerscanning.googleapis.com" ,

    #   "bigquery.googleapis.com",
    #   "bigquerymigration.googleapis.com",
    #   "bigquerystorage.googleapis.com",

    #   "servicemanagement.googleapis.com",
    #   "serviceusage.googleapis.com",

    #   "cloudbuild.googleapis.com",
    #   "cloudfunctions.googleapis.com",
    #   "containerregistry.googleapis.com",
    #   "containeranalysis.googleapis.com" ,
    #   "sourcerepo.googleapis.com",
    #   "pubsub.googleapis.com",
      
    #   "clouddebugger.googleapis.com",
    #   "cloudtrace.googleapis.com",

    #   "cloudasset.googleapis.com",
    #   "sql-component.googleapis.com"
 
    ]
}

variable "default_service_list" {
    type = list(string)
    default = [
      "compute.googleapis.com" ,
      "oslogin.googleapis.com" ,
      "cloudapis.googleapis.com" ,
      "logging.googleapis.com" ,
      "monitoring.googleapis.com" ,
      "cloudresourcemanager.googleapis.com" ,
      "iam.googleapis.com" 
    ]
}



# SA related

variable "sa_core_viewer" {
  default = "gcp-25-core-viewer"
  type    = string
  description = "Generic SA created as VIEWER in the project"
}

variable "sa_list" {
    type = list(string)
    default = [
        "test1234"  ,
        "test-run" ,
        "test-vm" 
    ]
}

variable "cicd_terra" {
    type    = string
    description = "CICD SA created to be used for Terraform"
}

# variable "sa_list" {
#     type = list(object({
#         name = string ,
#         description = string 
#     }))
#     default = [
#         { "name" : "test1234" 
#          "description" : "aaaaaaaa"
#         } ,
#         # "test-run" ,
#         # "test-vm" 
#     ]
# }

# variable "sa_list" {
#     type = list(map)
#     default = [
#         {
#         "test1234" = "aaaaaaaa"
    
#         # "test-run" ,
#         # "test-vm" 
#         }
#     ]
# }






# GCS related

variable "first_suffix"{
    type    = string 
    default = "xxx"
}

variable "gcs_loc_us" {
    type    = string
    default = "US`"
}



# VPC

# variable "vpc_name_1" {
#     type = string
#     description = "Name of 1st VPC"
# }

variable "cidr1" {
    type    = string
}

variable "subnet_map" {
    description = "The list of subnet values"

    type = map(object({
     name = string ,
     cidr = string ,
     region = string
    }))

    default = {
        "sub1" = {
         name = "subnet01"
         cidr = "10.1.0.0/16" 
         region = "us-central1"
      
        }
         "sub2" = {
         name = "subnet02"
         cidr = "10.2.0.0/16"
         region = "us-east4"
        }
    }
}


# GCE

variable "mac_type_e2m" {
    type = string
    default = "e2-medium"
    description = "VM's machine type"
}

variable "vm_name" {
    type = string
    description = "Name of the VM"
}

variable "vm_image" {
    type = string
    description = "Image for VM"
    default = "debian-cloud/debian-11"
  
}

# variable "vpc_name" {
#     type = string
#     default = "DUMMY"
# }

variable "subnet_name" {
    type = string
    default = "DUMMY"
}

variable "sa_mail" {
    type = string
    description = "SA for VM"
    default = "XXX"
}



variable autoscaling {
  description = "Enable autoscaling."
  default     = false
}

variable max_replicas {
  description = "Autoscaling, max replicas."
  default     = 4
}

variable min_replicas {
  description = "Autoscaling, min replics."
  default     = 1
}

variable cooldown_period {
  description = "Autoscaling, cooldown period in seconds."
  default     = 60
}

variable autoscaling_cpu {
  description = "Autoscaling, cpu utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#cpu_utilization"
  type        = number
  default     = 0.5
}

variable autoscaling_metric {
  description = "Autoscaling, metric policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#metric"
  type        = list
  default     = []
}

variable autoscaling_lb {
  description = "Autoscaling, load balancing utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#load_balancing_utilization"
  type        = list
  default     = []
}

variable distribution_policy_zones {
  description = "The distribution policy for this managed instance group when zonal=false. Default is all zones in given region."
  type        = list
  default     = []
}

variable mac_type_f1m {
  description = "Machine type for the VMs in the instance group."
  default     = "f1-micro"
}

variable "preemptible" {
  description = "Use preemptible instances - lower price but short-lived instances. See https://cloud.google.com/compute/docs/instances/preemptible for more details"
  default     = "false"
}

variable "automatic_restart" {
  description = "Automatically restart the instance if terminated by GCP - Set to false if using preemptible instances"
  default     = "true"
}

