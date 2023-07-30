## Google Cloud project

data "google_project" "my_project" {
    project_id = var.project_id
}




## GCP APIs


resource "google_project_service" "gcp_services_enable_default" {
  project = var.project_id
  for_each = toset(var.default_service_list)
  service = each.key
  disable_on_destroy = false
}
resource "google_project_service" "gcp_services_enable" {
  project = var.project_id
  for_each = toset(var.service_list)
  service = each.key
  disable_on_destroy = false
}



## Service Account setup as VIEWER - TEST only

resource "google_service_account" "service_account" {
  account_id   = var.sa_generic

}

resource "google_project_iam_member" "sa_core-viewer-binding" {
  project       = var.project_id
  role          = "roles/viewer"
  member        = "serviceAccount:${google_service_account.service_account.email}"
}



# creating as generic SA
resource "google_service_account" "custom_sa" {
  project       = var.project_id
  for_each = toset(var.sa_list)
  account_id   = each.key
  # description =   "Service Account"
  description = each.value
}

