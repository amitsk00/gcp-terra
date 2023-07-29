

resource "google_storage_bucket" "pluto_bucket" {
  project  = var.project_id
  name     = "${var.project_id}${var.bucketsuffix}"
  location = "US"
}