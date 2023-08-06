# VPC network

resource "google_compute_network" "vpc1" {
  project = var.project_id
  name = "network-1"
  auto_create_subnetworks = false
  mtu                     = 1460
}


# Firewalls

resource "google_compute_firewall" "vpc1-icmp" {
  name    = "fw-vpc1-a-i-icmp"
  project = var.project_id
  network = google_compute_network.vpc1.name
  description = "Allow ICMP on VPC1 with tag"
  direction = "INGRESS"

  allow {
    protocol = "icmp"
  }

  source_tags = ["fw-vpc1-icmp"]
}

  
resource "google_compute_firewall" "vpc1-ssh" {
  name    = "fw-vpc1-a-i-ssh"
  project = var.project_id
  network = google_compute_network.vpc1.name
  description = "Allow SSH RDP on VPC1 with tag"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["3389" , "22"]
  }

  source_tags = ["fw-vpc1-ssh"]
}

resource "google_compute_firewall" "vpc1-http" {
  name    = "fw-vpc1-a-i-http"
  project = var.project_id
  network = google_compute_network.vpc1.name
  description = "Allow HTTP on VPC1 with tag"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  source_tags = ["fw-vpc1-http"]
}

resource "google_compute_firewall" "vpc1-https" {
  name    = "fw-vpc1-a-i-https"
  project = var.project_id
  network = google_compute_network.vpc1.name
  description = "Allow HTTPS on VPC1 with tag"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_tags = ["fw-vpc1-https"]
}

resource "google_compute_firewall" "vpc1-ubuntu" {
  name    = "fw-vpc1-a-i-ubuntu"
  project = var.project_id
  network = google_compute_network.vpc1.name
  description = "Allow all on VPC1 from my local Ubuntu laptop"
  direction = "INGRESS"

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = [ 22 , 25 , 80 , 443 , 8080 , 3389 ]
  }

  source_tags = ["fw-vpc1-ubuntu"]
}





## SUbnets

resource "google_compute_subnetwork" "vpc1-us-central1" {
  name          = "subnet-vpc1-central1"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc1.id
  private_ip_google_access = true 

  secondary_ip_range {
    # range_name    = "tf-test-secondary-range-update1"
    # ip_cidr_range = "192.168.10.0/24"
  }

  log_config {
    aggregation_interval = "INTERVAL_15_MIN"
    flow_sampling        = 0.1
    metadata             = "INCLUDE_ALL_METADATA"
  }

}


