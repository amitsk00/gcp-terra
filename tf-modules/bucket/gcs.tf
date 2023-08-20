

resource "google_storage_bucket" "first_bucket" {
  project  = var.project_id
  name     = "${var.project_id}-${var.first_suffix}"
  location      = var.gcs_loc_us
  force_destroy = true
  public_access_prevention = "enforced"

  autoclass {
    enabled = true
  }

  retention_policy {
    retention_period = 60 
  }
  lifecycle_rule {
    condition {
      age = 300
    }
    action {
      type = "Delete"
    }
  }

}

resource "google_storage_bucket" "custom_bucket" {
  project  = var.project_id
  name          = "${var.project_id}-custom"
  location      = var.gcs_loc_us
  force_destroy = true
  public_access_prevention = "enforced"

  autoclass {
    enabled = true
  }
  lifecycle_rule {
    condition {
      age = 300
    }
    action {
      type = "Delete"
    }
  }


}

