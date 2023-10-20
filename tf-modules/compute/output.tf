output "nic0_ip1" {
  value = google_compute_instance.test1.network_interface.0.network_ip
}


output "zone_list" {
    value = "${local.distribution_zones["default"][0]}"
} 


output "mig_zonal" {
    value = google_compute_instance_group_manager.mig_zonal.id 
}

output "mig_regional" {
    value = google_compute_region_instance_group_manager.mig_regional.id 
}

