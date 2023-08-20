output "ip1" {
  value = google_compute_instance.test1.network_interface.0.network_ip
}

