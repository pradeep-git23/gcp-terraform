resource "google_compute_instance_group_manager" "ba-instance-grp-manager" {
  name               = "${var.ba_instance_group}"
  base_instance_name = "ba-binstance"
  #instance_template  = google_compute_instance_template.this.id
  zone               = var.zone
  version {
    name             = "v1"
    instance_template  = google_compute_instance_template.ba-instance-temp.id
      }
  target_size        = 2
  named_port {
    name = "tcp"
    port = 80
  }
  auto_healing_policies {
    health_check   = google_compute_health_check.ba-https-health-check.self_link
    initial_delay_sec = 300
  }
}
