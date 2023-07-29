output "project_number" {
    value = data.google_project.my_project.number
}


output "ip" {
  value = google_compute_network.vpc_network.self_link
}
