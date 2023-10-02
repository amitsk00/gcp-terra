output "project_number" {
    value = data.google_project.my_project.number
}

output "sa_vm" {
    value = module.project-init.sa_vm
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
output vpc1 {
    value = module.project-network.network1-selflink
}

output subnet-default {
    value = module.project-network.subnet-default
}




# VM

output nic0_ip1 {
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



# TEST
