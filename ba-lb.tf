resource "google_compute_url_map" "ba-lb" {
  name            = "${var.lb_name}"
  default_service = google_compute_region_backend_service.ba-backend.id
}

resource "google_compute_target_https_proxy" "ba-https" {
  name             = "${var.lb_name}-http-proxy"
  url_map          = google_compute_url_map.backenlb.id
  }

resource "google_compute_forwarding_rule" "default" {
  name                  = "${var.lb_name}-frontend-fw-rule"
  region                = "us-central1"
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL"
  all_ports             = true
  allow_global_access   = true
  backend_service       = google_compute_backend_service.ba-backend.id
}
resource "google_compute_backend_service" "ba-backend" {
  name                  = "${var.lb_name}-ba-backend"
  region                = "us-central1"
  load_balancing_scheme = "INTERNAL_SELF_MANAGED"
  protocol              = "TCP"
  health_checks         = [google_compute_health_check.ba-hc.id]
  backend {
   group                 = google_compute_instance_group_manager.ba-instance-grp-manager.instance_group
   balancing_mode        = "UTILIZATION"
   capacity_scaler       = 1.0
   max_rate_per_instance = 500
  }
}

