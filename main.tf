
# locals {
#     json_sa_data = jsondecode(file("${path.module}/json-files/sa.json"))

#     json_sa1_data = jsondecode(file("${path.module}/json-files/sa1.json"))
#     all_sa = [for user in local.json_sa1_data.custom_sa : { (user.name) : (user.description) }]
# }

# output "sa_output" {
#   value = local.all_sa
# }

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




module "project-init" {
    source = "./tf-modules/project"

    project_id = var.project_id
    region = var.region
    zone = var.zone
    main_user = var.main_user 

    sa_list = var.sa_list 
    sa_core_viewer = var.sa_core_viewer
    # sa_list = local.json_sa_data.my_sa_list 

    default_service_list = var.default_service_list
    service_list = var.service_list    

    cicd_terra = var.cicd_terra
}




module "project-gcs" {
    source = "./tf-modules/bucket"

    project_id = var.project_id
    first_suffix = var.first_suffix
    gcs_loc_us = var.gcs_loc_us
  
}


module "project-network" {
    source = "./tf-modules/network"

    project_id = var.project_id
    cidr1 = var.cidr1 
    region = var.region 
    # vpc_name_1 
    subnet_map = var.subnet_map

    depends_on = [ module.project-init]
}


module "project-vm" {
    source = "./tf-modules/compute"

    project_id = var.project_id
    region = var.region
    vm_name = var.vm_name
    zone = var.zone
    mac_type_e2m = var.mac_type_e2m
    vm_image = var.vm_image 
    

    # vpc_name = module.project-network.network1-selflink
    subnet_name = module.project-network.subnet-default

    sa_mail = module.project-init.email_core_viewer
    sa_list = var.sa_list 
    sa_email_list = module.project-init.sa_vm
    

    autoscaling = var.autoscaling
    max_replicas = var.max_replicas
    min_replicas = var.min_replicas
    cooldown_period = var.cooldown_period
    autoscaling_cpu = var.autoscaling_cpu
    mac_type_f1m = var.mac_type_f1m 


    depends_on = [ module.project-network ]
  
}



