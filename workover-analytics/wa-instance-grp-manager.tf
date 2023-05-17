resource "google_compute_instance_group_manager" "wa-instance-grp-manager" {
  name               = "${var.wa_instance_group}-${data.local_file.stdout.content}"
  base_instance_name = "${var.wa_instance_group}"
  zone               = var.zone
  version {
    name             = "${var.deploy_version}-${data.local_file.stdout.content}"
    instance_template  = google_compute_instance_template.wa-instance-temp.id
      }
  target_size        = 1
  named_port {
    name = "tcp"
    port = 80
  }
  auto_healing_policies {
    health_check   = google_compute_health_check.wa-https-health-check.self_link
    initial_delay_sec = 300
  }
}
