## Google Cloud project

data "google_project" "my_project" {
    project_id = var.project_id
}








## Service Account setup as VIEWER only

resource "google_service_account" "sa_core_viewer" {
  account_id   = var.sa_core_viewer

}

resource "google_project_iam_member" "sa_core-viewer-binding" {
  project       = var.project_id
  role          = "roles/viewer"
  member        = "serviceAccount:${google_service_account.sa_core_viewer.email}"
}



# creating SA from list 
resource "google_service_account" "custom_sa" {
  project       = var.project_id
  for_each = toset(var.sa_list)
  account_id   = each.key
  # description =   "Service Account"
  description = each.value
}

