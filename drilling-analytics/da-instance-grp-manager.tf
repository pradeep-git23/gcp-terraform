resource "google_compute_instance_group_manager" "da-instance-grp-manager" {
  name               = "${var.da_instance_group}-${data.local_file.stdout.content}"
  base_instance_name = "${var.da_instance_group}"
  #instance_template  = google_compute_instance_template.this.id
  zone               = var.zone
  version {
    name             = "v1"
    instance_template  = google_compute_instance_template.da-instance-temp.id
      }
  target_size        = 1
  named_port {
    name = "tcp"
    port = 80
  }
  auto_healing_policies {
    health_check   = google_compute_health_check.da-https-health-check.self_link
    initial_delay_sec = 300
  }
}
