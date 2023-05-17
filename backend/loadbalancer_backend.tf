resource "google_compute_backend_service" "this" {
  name        =  "${var.loadbalancer_name}-backend-service"
  port_name   = "https"
  protocol    = "HTTPS"
  timeout_sec = 10

  #health_checks = [google_compute_https_health_check.this.id]
  health_checks = [google_compute_health_check.https_health_check.self_link]

  backend {
   group                 = google_compute_instance_group_manager.this.instance_group
   balancing_mode        = "UTILIZATION"
   capacity_scaler       = 1.0
   max_rate_per_instance = 500
  }
}


