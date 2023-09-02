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

