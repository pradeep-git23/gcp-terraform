resource "google_compute_instance_group_manager" "wa-instance-grp-manager" {
  name               = "${var.wa-it}"
  base_instance_name = "wa-binstance"
  zone               = var.zone
  version {
    name             = "v1"
    instance_template  = google_compute_instance_template.wa-instance-temp.id
      }
  target_size        = 2
  named_port {
    name = "tcp"
    port = 80
  }
  auto_healing_policies {
    health_check   = google_compute_health_check.wa-https-health-check.self_link
    initial_delay_sec = 300
  }
}
