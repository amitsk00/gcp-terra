

locals {
    sa_for_vm  = one([ for item in var.sa_list : item if can(regex("vm", item)) ])
}


data "google_compute_image" "my_image" {
  family  = "debian-11"
  project = "debian-cloud"
}

resource "google_compute_disk" "foobar" {
  name  = "existing-disk"
  image = data.google_compute_image.my_image.self_link
  size  = 10
  type  = "pd-ssd"
  zone  =  var.zone
}


resource "google_compute_instance_template" "lb-mig-tmpl" {
  name        = "vm-tmpl-lb1"
  description = "This template is used to create MIG as backend for LB."

  tags = ["foo", "bar"]

  labels = {
    environment = "dev"
    foo = "bar" 
  }

  metadata = {
    foo = "bar"
  }

  instance_description = "LB related "
  machine_type         = "e2-medium"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  disk {
    source_image      = "debian-cloud/debian-11"
    auto_delete       = true
    boot              = true
    // backup the disk every day
    # resource_policies = [google_compute_resource_policy.daily_backup.id]
  }

  // Use an existing disk resource
  disk {
    // Instance Templates reference disks by name, not self link
    source      = google_compute_disk.foobar.name
    auto_delete = false
    boot        = false
  }

  network_interface {
    subnetwork = var.subnet_name
  }



  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # email  = var.sa_mail
    email = local.sa_for_vm
    scopes = ["cloud-platform"]
  }
}

