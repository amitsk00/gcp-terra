
variable "module_enabled" {
  description = ""
  default     = true
}


variable "project_id" {}

variable "credentials_file" {
  default = "key.json"
}

variable "region" {
  type        = string
  description = " Region name"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "Zone name"
  default     = "us-central1-c"
}


variable "terra_backend_gcs" {
  type        = string
  description = "GCS bucket for Terraform backend"

}
variable "terra_backend_prefix" {
  type        = string
  description = "GCS bucket prefix for Terraform backend"

}




variable "service_list" {
  type = list(string)
  default = [
    "storage.googleapis.com",
    "storage-api.googleapis.com",
    #   "storage-component.googleapis.com" ,


    "bigquery.googleapis.com",
    "bigquerymigration.googleapis.com",
    "bigquerystorage.googleapis.com",


    "serviceusage.googleapis.com",
    "cloudbuild.googleapis.com",

    #   "sourcerepo.googleapis.com",
    #   "pubsub.googleapis.com",

    #   "clouddebugger.googleapis.com",
    #   "cloudtrace.googleapis.com",

    #   "cloudasset.googleapis.com",
    #   "sql-component.googleapis.com",
    #   "servicemanagement.googleapis.com",

  ]
}

variable "gke_service_list" {
  type = list(string)
  default = [
    "container.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudbilling.googleapis.com",
    "containerregistry.googleapis.com",
    "artifactregistry.googleapis.com",
    "containerscanning.googleapis.com",
    "oslogin.googleapis.com"
  ]
}

variable "cloud_run_service_list" {
  type = list(string)
  default = [
    "run.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudbilling.googleapis.com",
    "containerregistry.googleapis.com",
    "artifactregistry.googleapis.com",
    "containerscanning.googleapis.com",
    "compute.googleapis.com"
  ]
}

variable "cloud_functions_service_list" {
  type = list(string)
  default = [
    "cloudfunctions.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudbilling.googleapis.com",
    "containerregistry.googleapis.com",
    "artifactregistry.googleapis.com",
    "containerscanning.googleapis.com",
    "pubsub.googleapis.com"
  ]
}

locals {
  unique_services = distinct(concat(
    var.gke_service_list,
    var.cloud_run_service_list,
    var.cloud_functions_service_list,
    var.service_list
  ))
}


variable "default_service_list" {
  type = list(string)
  default = [
    "compute.googleapis.com",
    "oslogin.googleapis.com",
    "cloudapis.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "iam.googleapis.com",
    "recommender.googleapis.com",
    "cloudasset.googleapis.com"
  ]
}


variable "main_user" {
  type = string
}


variable "count_zonal_mig" {
  type = number
  default = 1
}

variable "count_regional_mig" {
  type = number
  default = 1
}


# AR related

variable "ar_repo_format_docker" {
  default = "DOCKER"
  type    = string

}


# SA related

variable "sa_core_viewer" {
  default     = "gcp-core-viewer"
  type        = string
  description = "Generic SA created as VIEWER in the project"
}

variable "sa_list" {
  type = list(string)
  default = [
    "test1234",
    "test-run",
    "test-vm"
  ]
}


variable "cicd_terra" {
  type        = string
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

variable "first_suffix" {
  type    = string
  default = "xxx"
}

variable "gcs_loc_us" {
  type    = string
  default = "US`"
}



# AR

variable "py_image_1" {
  type        = string
  description = "Image for Python"
  default     = "python:3.8"
  
}



# VPC

variable "vpc_name" {
    type = string
    description = "Name of 1st VPC"
}


variable "cidr1" {
  type = string
}

variable "subnet_map" {
  description = "The list of subnet values"

  type = map(object({
    name   = string,
    cidr   = string,
    region = string
  }))

  default = {
    "sub1" = {
      name   = "subnet01"
      cidr   = "10.1.0.0/16"
      region = "us-central1"

    }
    "sub2" = {
      name   = "subnet02"
      cidr   = "10.2.0.0/16"
      region = "us-east4"
    }
  }
}





# GCE

variable "mac_type_e2m" {
  type        = string
  default     = "e2-medium"
  description = "VM's machine type"
}

variable "vm_name" {
  type        = string
  description = "Name of the VM"
}

variable "vm_image" {
  type        = string
  description = "Image for VM"
  default     = "debian-cloud/debian-11"

}

variable "startup_url" {
  description = "The GCS URI to be used for startup file"
  type        = string
}

# variable "vpc_name" {
#     type = string
#     default = "DUMMY"
# }

variable "subnet_name" {
  type    = string
  default = "DUMMY"
}

variable "sa_core_viewer_email" {
  type        = string
  description = "SA for VM"
  default     = "XXX"
}

variable "sa_run_email" {
  type        = string
  description = "SA for Cloud Run"
  default = "xx"
  
}

variable "sa_vm_email" {
  type        = string
  description = "SA for GCE"
  default = "xx"
  
}

variable "metadata_vm" {
    type = list(object({
        key   = string
        value = string
    }))
    default = []
}


## MIG

variable "autoscaling" {
  description = "Enable autoscaling."
  default     = false
}

variable "max_replicas" {
  description = "Autoscaling, max replicas."
  default     = 4
}

variable "min_replicas" {
  description = "Autoscaling, min replics."
  default     = 1
}

variable "cooldown_period" {
  description = "Autoscaling, cooldown period in seconds."
  default     = 60
}

variable "autoscaling_cpu" {
  description = "Autoscaling, cpu utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#cpu_utilization"
  type        = number
  default     = 0.5
}

variable "autoscaling_metric" {
  description = "Autoscaling, metric policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#metric"
  type        = list(any)
  default     = []
}

variable "autoscaling_lb" {
  description = "Autoscaling, load balancing utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#load_balancing_utilization"
  type        = list(any)
  default     = []
}

variable "distribution_policy_zones" {
  description = "The distribution policy for this managed instance group when zonal=false. Default is all zones in given region."
  type        = list(any)
  default     = []
}

variable "mac_type_f1m" {
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


## GKE

variable "create_gke" {
  description = "Create GKE service"
  default     = false
  
}

## Run

variable "create_run" {
  description = "Create Cloud Run service"
  default     = false
  
}





# AR

variable "ar_repo_name" {
  description = "Artifact Repo name - 1st sample repo"
  type        = string
  default     = "xxx"
}
