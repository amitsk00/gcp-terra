output "project_number" {
    value = data.google_project.my_project.number
}



# GCS

# output "first_self_link" {
#     value = module.project-gcs.first_self_link
# }

output "first_url" {
    value = module.project-gcs.first_url       
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


# VM

output vm_ip1 {
    value = module.project-vm.ip1
}



