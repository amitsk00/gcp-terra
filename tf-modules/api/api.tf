
data "google_project" "my_project" {
    project_id = var.project_id
}




## GCP APIs


resource "google_project_service" "gcp_services_enable_default" {
  project =   data.google_project.my_project.project_id
  for_each = toset(var.default_service_list)
  service = each.key
  disable_on_destroy = false
}
resource "google_project_service" "gcp_services_enable" {
  # project = var.project_id
  for_each = toset(var.service_list)
  service = each.key
  disable_on_destroy = false
}