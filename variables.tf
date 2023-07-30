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