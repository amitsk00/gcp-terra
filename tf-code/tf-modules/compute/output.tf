output "nic0_ip1" {
  value = google_compute_instance.vm_template.network_interface.0.network_ip
}


output "host_vm_sa" {
  value = local.sa_email_vm
}

output "zone_list" {
    value = "${local.distribution_zones["default"][0]}"
} 

# MIG

output "mig_zonal" {
    value = google_compute_instance_group_manager.mig_zonal[*].id 
}

output "mig_regional" {
    value = google_compute_region_instance_group_manager.mig_regional[*].id 
}


# Run

output "run-py-service1" {
    # value = google_cloud_run_service.my-py-service1[each.key].name
    value = var.create_run ? keys(google_cloud_run_service.my-py-service1) : null
}


# # GKE

# output "name_gke" {
#     value = google_container_cluster.first_cluster[each.key].name
  
# }



## LB

output "lb_ip" {
    value = google_compute_global_address.default.address
}