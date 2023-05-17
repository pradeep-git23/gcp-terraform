resource "google_compute_managed_ssl_certificate" "ssl" {
   provider = google-beta
   name     = "${var.loadbalancer_name}-cert"
   managed {
    domains = [var.domain_name]
  }
}
