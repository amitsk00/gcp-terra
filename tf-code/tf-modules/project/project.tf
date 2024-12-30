## Google Cloud project



# data "google_project" "my_project" {
#     project_id = var.project_id
# }

locals {
  cicd_mail = "${var.cicd_terra}@${var.project_id}.iam.gserviceaccount.com"
}




## GCP APIs


resource "google_project_service" "gcp_services_enable_default" {
    # project =   data.google_project.my_project.project_id
    project =   var.project_id
    for_each = toset(var.default_service_list)
    service = each.key
    disable_on_destroy = false
}

resource "google_project_service" "gcp_services_enable" {
    # project = var.project_id
    for_each = toset(var.service_list)
    service = each.key
    disable_on_destroy = false

    depends_on = [ google_project_service.gcp_services_enable_default ]
}







## Service Account setup as VIEWER only

resource "google_service_account" "sa_core_viewer" {
  account_id   = var.sa_core_viewer
  description = "Core Viewer role almost like VIEWER"

  depends_on = [ google_project_service.gcp_services_enable ]

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
    description = each.key 

    depends_on = [ google_project_service.gcp_services_enable ]
}

resource "google_service_account_iam_member" "cicd_binding1" {
    # service_account_id = google_service_account.sa.name
    # for_each = toset(google_service_account.custom_sa.name)
    # service_account_id = each.value
    for_each = google_service_account.custom_sa
    service_account_id = each.value.id 
    role               = "roles/iam.serviceAccountUser"
    member = "serviceAccount:${local.cicd_mail}"

    depends_on = [ google_project_service.gcp_services_enable ]
}

resource "google_service_account_iam_member" "cicd_binding2" {
    # service_account_id = google_service_account.sa.name
    # for_each = toset(google_service_account.custom_sa.name)
    # service_account_id = each.value
    for_each = google_service_account.custom_sa
    service_account_id = each.value.id 
    role               = "roles/iam.serviceAccountTokenCreator"
    member = "serviceAccount:${local.cicd_mail}"

    depends_on = [ google_project_service.gcp_services_enable ]
}


resource "google_service_account_iam_member" "cicd_binding3" {
    # service_account_id = google_service_account.sa.name
    # for_each = toset(google_service_account.custom_sa.name)
    # service_account_id = each.value
    for_each = google_service_account.custom_sa
    service_account_id = each.value.id 
    role               = "roles/iam.serviceAccountUser"
    member = "user:${var.main_user}"

    depends_on = [ google_project_service.gcp_services_enable ]
}

resource "google_service_account_iam_member" "cicd_binding4" {
    # service_account_id = google_service_account.sa.name
    # for_each = toset(google_service_account.custom_sa.name)
    # service_account_id = each.value
    for_each = google_service_account.custom_sa
    service_account_id = each.value.id 
    role               = "roles/iam.serviceAccountTokenCreator"
    member = "user:${var.main_user}"

    depends_on = [ google_project_service.gcp_services_enable ]
}
