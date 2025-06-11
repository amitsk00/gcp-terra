# locals {
#   	create_gke_map = var.create_gke ? { "first-cluster" = true } : {}

# }


# resource "google_container_cluster" "first_cluster" {
#     # count    = var.create_gke ? 1 : 0
#     for_each = local.create_gke_map

#     name     = each.key
#     project  = var.project_id
#     location = var.region
#     network  = var.vpc_name
#     subnetwork = var.subnet_name

#     initial_node_count = 2

#     node_config {
#         machine_type = "e2-medium"
#         disk_size_gb = 30 
#         oauth_scopes = [
#         "https://www.googleapis.com/auth/cloud-platform",
#         ] 
#         preemptible = true 
#         # service_account = "default"

#     }
#     maintenance_policy {
#         daily_maintenance_window {
#         start_time = "03:00"
#         }
#     }
#     addons_config {
#         http_load_balancing {
#         disabled = false
#         }
#         horizontal_pod_autoscaling {
#         disabled = false
#         }
#         # kubernetes_dashboard {
#         #   disabled = false
#         # }
#         network_policy_config {
#         disabled = false
#         }
#     }
#     # master_auth {
#     #   username = ""
#     #   password = ""
#     #   client_certificate_config {
#     #     issue_client_certificate = false
#     #   }
#     # }

# }