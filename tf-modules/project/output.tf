# output "project_number" {
#     value = data.google_project.my_project.number
# }


output "email_core_viewer" {
    description = "Service account email for core viewer"
#   value       = try(data.google_service_account.sa_core_viewer.email, null)
    value = google_service_account.sa_core_viewer.email
}


# output "service_account" {
#   description = "Service account resource (for single use)."
#   value       = try(data.google_service_account.sa_list.service_accounts_list[0], null)
# }

# output "email" {
#   description = "Service account email (for single use)."
#   value       = try(data.google_service_account.sa_list.emails_list[0], null)
# }

