resource "google_compute_instance" "test1" {
  name         = var.vm_name 
  machine_type = var.mac_type_e2m
  zone         = var.zone 

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = var.vm_image
      labels = {
        my_label = "value"
      }
    }
  }

  # // Local SSD disk
  # scratch_disk {
  #   interface = "SCSI"
  # }

  network_interface {
    # network = var.vpc_name
    subnetwork = var.subnet_name

    # access_config {
    #   // Ephemeral public IP
    # }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = var.startup_url

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

