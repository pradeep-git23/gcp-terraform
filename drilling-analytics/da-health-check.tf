resource "google_compute_health_check" "da-https-health-check" {
  name                = "da-health-checks"
  check_interval_sec  = 30
  timeout_sec         = 10
  healthy_threshold   = 3
  unhealthy_threshold = 5

  tcp_health_check {
    port         = 80
    response     = "Healthy"
  }
}
