variable "project_id" {
  type    = string
}

variable "region" {
  default = "us-central1"
  type    = string
}

variable "zone" {
    type = string
    description = "Zone name"
    default = "us-central1-c"
}

variable "topic" {
  default = "activities"
  type    = string
}

variable "function" {
  default = "pyPubTrig"
  type    = string
}


variable "bucketsuffix" {
  default = "-bucket"
  type    = string
}

variable "asset_list" {
    type = list(string)
    default = [
        "compute.googleapis.com/Instance",
        "compute.googleapis.com/Image",
        "compute.googleapis.com/Snapshot",
        "storage.googleapis.com/Bucket",
    ]
}

variable "asset_list_spanner" {
    type = list(string)
    default = [
        "spanner.googleapis.com/InstanceConfig" ,
        "spanner.googleapis.com/Instance" ,
        "spanner.googleapis.com/Database" ,
        "spanner.googleapis.com/Backup"
    ]
}






variable "sa_core_viewer" {

}


variable "cicd_terra" {
    type    = string
    description = "CICD SA created to be used for Terraform"
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
