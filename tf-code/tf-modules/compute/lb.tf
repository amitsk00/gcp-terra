

resource "google_compute_address" "default" {
  name = "load-balancer-ip"
}

resource "google_compute_global_address" "default" {
  name = "load-balancer-ip"
}

locals {
   mig_name = google_compute_instance_group_manager.mig_zonal[0].instance_group
}

resource "google_compute_backend_service" "default" {
  name                  = "load-generator-backend"
#   health_checks         = [google_compute_health_check.default.self_link]
  health_checks         = [google_compute_health_check.autohealing_mig.self_link]
  load_balancing_scheme = "EXTERNAL"
  port_name             = "http"
  protocol              = "HTTP"
  timeout_sec           = 10

  backend {
    group = local.mig_name
  }
}

resource "google_compute_url_map" "default" {
  name            = "load-generator-url-map"
  default_service = google_compute_backend_service.default.self_link
}

resource "google_compute_target_http_proxy" "default" {
  name   = "load-generator-http-proxy"
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "load-generator-forwarding-rule"
  ip_address = google_compute_global_address.default.address
  port_range = "80"
  target     = google_compute_target_http_proxy.default.self_link
}