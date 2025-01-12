
locals {
    # repo = module.project-ar.ar_repo_name
    py-repo-name = "${var.region}-docker.pkg.dev/${var.project_id}/${var.ar_repo_name}"
	create_run_map = var.create_run ? { "my-cloud-run-service" = true } : {}

}


resource "google_cloud_run_service" "my-py-service1" {
	# count    = var.create_run ? 1 : 0
	for_each = local.create_run_map

	name     = each.key
	location = var.region
	project  = var.project_id

	template {
	spec {
		containers {
		# image = "${var.ar_repo_name}/py-v1:latest"  
		image = "${local.py-repo-name}/py-v1:latest"  
		resources {
			limits = {
			memory = "256Mi"
			cpu    = "1"
			}
		}
		ports {
			container_port = 5000
		}        
		}
	}
	}

	traffic {
		percent         = 100
		latest_revision = true
	}
}

resource "google_cloud_run_service_iam_member" "invoker" {
	# count    = var.create_run ? 1 : 0
    for_each = google_cloud_run_service.my-py-service1

	# service = google_cloud_run_service.my-py-service1[each.key].name
	# location = google_cloud_run_service.my-py-service1[each.key].location
	# project  = google_cloud_run_service.my-py-service1[each.key].project
    service = each.key
    location = each.value.location
    project = each.value.project

	role     = "roles/run.invoker"
	member   = "allUsers"
	
}