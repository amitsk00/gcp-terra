
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

# terraform {
#   backend "gcs" {}
# }

terraform {
  backend "gcs" {
    bucket = "ask-proj-35-terraform"
    prefix = "state"
  }
}


module "project-init" {
  source = "./tf-modules/project"

  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  main_user  = var.main_user

  sa_list        = var.sa_list
  sa_core_viewer = var.sa_core_viewer
  # sa_list = local.json_sa_data.my_sa_list 

  default_service_list = var.default_service_list
  # service_list = var.service_list    
  service_list = local.unique_services

  cicd_terra = var.cicd_terra
}




module "project-gcs" {
  source = "./tf-modules/bucket"

  project_id   = var.project_id
  first_suffix = var.first_suffix
  gcs_loc_us   = var.gcs_loc_us

}


module "project-ar" {
  source = "./tf-modules/ar"

  project_id = var.project_id
  region     = var.region

  # ar_repo_name = var.ar_repo_name
  # ar_repo_id = var.ar_repo_id
  ar_repo_format_docker = var.ar_repo_format_docker
  # ar_repo_description = var.ar_repo_description

  py_image_1 = var.py_image_1
  main_user  = var.main_user
  
}


module "project-network" {
    source = "./tf-modules/network"

    project_id = var.project_id
    vpc_name = var.vpc_name
    cidr1      = var.cidr1
    region     = var.region
    # vpc_name_1 
    subnet_map = var.subnet_map

    depends_on = [module.project-init]
}


module "project-vm" {
    source = "./tf-modules/compute"

    project_id   = var.project_id
    region       = var.region
    vm_name      = var.vm_name
    zone         = var.zone
    mac_type_e2m = var.mac_type_e2m
    vm_image     = var.vm_image
    # metadata_vm  = var.metadata_vm

    startup_url = var.startup_url

    vpc_name = module.project-network.network1-selflink 
    subnet_name = module.project-network.subnet-default

    sa_core_viewer_email       = module.project-init.email_core_viewer
    sa_list       = var.sa_list
    sa_email_list = module.project-init.sa_vm
    sa_run_email = module.project-init.sa_run_email
    sa_vm_email = module.project-init.sa_vm_email


    count_regional_mig = var.count_regional_mig
    count_zonal_mig = var.count_zonal_mig
    create_run = var.create_run
    create_gke = var.create_gke


    autoscaling     = var.autoscaling
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas
    cooldown_period = var.cooldown_period
    autoscaling_cpu = var.autoscaling_cpu
    mac_type_f1m    = var.mac_type_f1m

    ar_repo_name = module.project-ar.ar_repo_name


    depends_on = [module.project-network]

}



