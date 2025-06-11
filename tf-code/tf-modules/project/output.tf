output "project_number" {
    value = data.google_project.my_project.number
}


output "email_core_viewer" {
    description = "Service account email for core viewer"
#   value       = try(data.google_service_account.sa_core_viewer.email, null)
    value = google_service_account.sa_core_viewer.email
}



####

locals {
  sa_emails = values(google_service_account.custom_sa)[*].email
  sa_run_email = one([for item in local.sa_emails : item if can(regex("run", item))])
  sa_vm_email  = one([for item in local.sa_emails : item if can(regex("vm", item))])
}

output "sa_run_email" {
  value       = local.sa_run_email
  description = "Service account for Cloud Run"
}

output "sa_vm_email" {
  value       = local.sa_vm_email
  description = "Service account for Cloud GCE"
}

output "sa_vm" {  # Keep this output for external use
  description = "Service account resource (for VM)."
  value       = local.sa_emails
}


####





# output "service_account" {
#   description = "Service account resource (for single use)."
#   value       = try(data.google_service_account.sa_list.service_accounts_list[0], null)
# }

# output "email" {
#   description = "Service account email (for single use)."
#   value       = try(data.google_service_account.sa_list.emails_list[0], null)
# }
