output "network1-selflink" {
  value = google_compute_network.vpc1.self_link
}

output "network1-gw" {
  value = google_compute_network.vpc1.gateway_ipv4
}


output "subnet1-gw" {
  value = google_compute_subnetwork.vpc1-us-central1.gateway_address
}

output "subnet-default" {
  value = google_compute_subnetwork.vpc1-us-central1.name
}