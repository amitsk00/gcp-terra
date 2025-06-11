


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

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["fw-vpc1-icmp"]

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

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["fw-vpc1-ssh"]

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

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["fw-vpc1-http"]

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

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["fw-vpc1-https"]

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

    log_config {
          metadata = "INCLUDE_ALL_METADATA"
    } 

    source_ranges = ["192.168.1.0/24"]
    target_tags = ["fw-vpc1-ubuntu"]

    depends_on = [ google_compute_network.vpc1 ]
  
}



resource "google_compute_firewall" "vpc1-hc-allow" {
    name    = "fw-vpc1-a-i-hc"
    project = var.project_id
    network = google_compute_network.vpc1.name
    description = "Allow for health check of MIG"
    direction = "INGRESS"

    allow {
      protocol = "tcp"
      # ports    = [ 22 , 25 , 80 , 443 , 8080 , 3389 ]
    }

    source_ranges = [ 
        "130.211.0.0/22" , 
        "35.191.0.0/16"  , 
        "209.85.152.0/22" , 
        "209.85.204.0/22" 
    ]
    target_tags = ["fw-vpc1-a-i-hc"]

    depends_on = [ google_compute_network.vpc1 ]
  
}


resource "google_compute_firewall" "vpc1-all_allow" {
    name    = "fw-vpc1-a-i-all"
    project = var.project_id
    network = google_compute_network.vpc1.name
    description = "Allow everything - generic"
    direction = "INGRESS"

    allow {
      protocol = "tcp"
      ports    = [ 22 , 25 , 80 , 443 , 8080 , 3389 ]
    }

    source_ranges = [ 
      "0.0.0.0/0" ,  
      "35.235.240.0/20" , 
      "130.211.0.0/22" , 
      "35.191.0.0/16" 
    ]
    target_tags = ["fw-vpc1-a-i-all"]

    depends_on = [ google_compute_network.vpc1 ]
  
}

# resource "google_compute_firewall" "vpc1-hc_allow" {
#     name        = "fw-vpc1-a-i-hc"
#     project     = var.project_id
#     network     = google_compute_network.vpc1.name
#     description = "Allow health check probes for MIG"
#     direction   = "INGRESS"

#     allow {
#         protocol = "tcp"
#         # ports    = ["8080"]  # Add the port used by your TCP health check
#     }

#     source_ranges = [
#         "130.211.0.0/22",
#         "35.191.0.0/16",
#         "209.85.152.0/22",
#         "209.85.204.0/22"
#     ]

#     target_tags = ["fw-vpc1-a-i-hc"]

#     depends_on = [google_compute_network.vpc1]
# }