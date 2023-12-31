


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

  depends_on = [ google_compute_network.vpc1 ]
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

  depends_on = [ google_compute_network.vpc1 ]
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

  depends_on = [ google_compute_network.vpc1 ]
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

  depends_on = [ google_compute_network.vpc1 ]
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

  depends_on = [ google_compute_network.vpc1 ]
  
}


