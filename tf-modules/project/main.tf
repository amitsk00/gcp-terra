## Google Cloud project

data "google_project" "my_project" {
    project_id = var.project_id
}

output "project_number" {
    value = data.google_project.project.number
}


## GCP APIs

resource "google_project_service" "gcp_services_enable" {
  project = var.project_id
  for_each = toset(var.service_list)
  service = each.key
  disable_on_destroy = false
}

resource "google_project_service" "gcp_services_enable_default" {
  project = var.project_id
  for_each = toset(var.default_service_list)
  service = each.key
  disable_on_destroy = false
}


## Service Account setup

resource "google_service_account" "service_account" {
  account_id   = var.function_sa
}

resource "google_project_iam_member" "function_sa_binding" {
  project       = var.project_id
  role          = "roles/viewer"
  member        = "serviceAccount:${google_service_account.service_account.email}"
}


