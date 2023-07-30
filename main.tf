
locals {
    json_sa_data = jsondecode(file("${path.module}/json-files/sa.json"))

    json_sa1_data = jsondecode(file("${path.module}/json-files/sa1.json"))
    all_sa = [for user in local.json_sa1_data.custom_sa : { (user.name) : (user.description) }]
}

output "sa_output" {
  value = local.all_sa
}

# provider "google" {
# #   credentials = file(var.credentials_file)

#     project = var.project
#     region  = var.region
#     zone    = var.zone
# }

# resource "time_resource" "delay30" {
#   create_duration = "30s"
# }

data "google_project" "my_project" {
    project_id = var.project_id
}



# module "project-init" {
#   source = "./tf-modules/project"

#   project_id = var.project_id
#   region = var.region
#   zone = var.zone

#   default_service_list = var.default_service_list
#   service_list = var.service_list
#   # sa_list = var.sa_list 
#   sa_list = local.json_sa_data.my_sa_list 
# }


