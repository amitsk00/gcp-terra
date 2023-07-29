# provider "google" {
# #   credentials = file(var.credentials_file)

#     project = var.project
#     region  = var.region
#     zone    = var.zone
# }

# resource "time_resource" "delay30" {
#   create_duration = "30s"
# }

data "google_project" "my_project" {
    project_id = var.project_id
}



# resource "google_compute_network" "vpc_network" {
#   project = var.project_id
#   name = "terraform-network"
# }


resource "google_service_account" "default" {
  account_id   = "sa7899"
  display_name = "Service Account"
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
