resource "google_artifact_registry_repository" "my_py_repo" {
    provider = google-beta

    project  = var.project_id
    location     = var.region
    repository_id = "ar-py-repo"
    format   =  var.ar_repo_format_docker # or "MAVEN", "NPM", "APT", "YUM", etc.
    description = "My Artifact Registry repository in docker for PY programs"
}


# # push the existing image to AR

# resource "null_resource" "build_and_push_image" {
#   provisioner "local-exec" {
#     command = <<EOT
#       gcloud auth configure-docker
#     #   docker build -t my-python-app:latest .
#     #   docker tag my-python-app:latest ${google_artifact_registry_repository.my_py_repo.location}-docker.pkg.dev/${google_artifact_registry_repository.my_py_repo.project}/${google_artifact_registry_repository.my_py_repo.repository_id}/${var.py_image_1}:latest
#       sudo docker push ${google_artifact_registry_repository.my_py_repo.location}-docker.pkg.dev/${google_artifact_registry_repository.my_py_repo.project}/${google_artifact_registry_repository.my_py_repo.repository_id}/${var.py_image_1}:latest
#     EOT
#   }
# }