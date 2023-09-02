output "project_number" {
    value = data.google_project.my_project.number
}

output "sa_vm" {
    value = module.project-init.sa_vm
}

# GCS

# output "first_self_link" {
#     value = module.project-gcs.first_self_link
# }

output "first_bucket_url" {
    value = module.project-gcs.first_bucket_url       
}

# output "custom_self_link" {
#     value = module.project-gcs.custom_self_link
# }

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

output vm_ip1 {
    value = module.project-vm.ip1
}



