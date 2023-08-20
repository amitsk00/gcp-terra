# VPC network

resource "google_compute_network" "vpc1" {
  project = var.project_id
  name = "network-1"
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode = "GLOBAL"
}




## SUbnets

resource "google_compute_subnetwork" "vpc1-us-central1" {
  region        =  var.region
  name          =  "network1-${var.region}"
  ip_cidr_range = var.cidr1
  network       = google_compute_network.vpc1.id
  private_ip_google_access = true 

  # secondary_ip_range {
  #   range_name    = "tf-test-secondary-range-update1"
  #   ip_cidr_range = "192.168.10.0/24"
  # }

  log_config {
    aggregation_interval = "INTERVAL_15_MIN"
    flow_sampling        = 0.1
    metadata             = "INCLUDE_ALL_METADATA"
  }

  depends_on = [ google_compute_network.vpc1 ]

}


resource "google_compute_subnetwork" "subnet_list" {
  for_each = var.subnet_map
    name          = "${google_compute_network.vpc1.name}-${each.value.name}"
    ip_cidr_range = "${each.value.cidr}"
    region        = "${each.value.region}"
    network       = google_compute_network.vpc1.id

  depends_on = [ google_compute_network.vpc1 ]

}

