output "ar_repo_name" {
  value = google_artifact_registry_repository.my_py_repo.name
}

  
output "ar_repo_url" {
  value = google_artifact_registry_repository.my_py_repo.repository_id
}