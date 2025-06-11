output "project_number" {
  value = data.google_project.my_project.number
}

output "sa_vm_list" {
  value = module.project-init.sa_vm
}

output sa_run_email {
  value = module.project-init.sa_run_email
}

output "sa_vm_email" {
  value = module.project-init.sa_vm_email
  
}

# AR

output "my-py-repo-name" {
  value = module.project-ar.ar_repo_name
}

output "ar_repo_url" {
  value = module.project-ar.ar_repo_url
}



# GCS

output "first_bucket_url" {
  value = module.project-gcs.first_bucket_url
}



output "custom_url" {
  value = module.project-gcs.custom_url
}

output "sa-core-view" {
  value = module.project-init.email_core_viewer
}




# VPC
output "vpc1" {
  value = module.project-network.network1-selflink
}

output "subnet-default" {
  value = module.project-network.subnet-default
}




# VM

output "nic0_ip1" {
  value = module.project-vm.nic0_ip1
}

output "zone_list" {
  value = module.project-vm.zone_list
}

output "mig_zonal" {
  value = module.project-vm.mig_zonal
}

output "mig_regional" {
  value = module.project-vm.mig_regional
}


# Run

output "run-py-service1" {
  value = module.project-vm.run-py-service1
}


# # GKE

# output "name_gke" {
#   value = module.project-vm.name_gke 
# }


## LB 

output "lb_ip" {
  value = module.project-vm.lb_ip
}



# TEST

output "host_vm_sa" {
  value = module.project-vm.host_vm_sa
}
