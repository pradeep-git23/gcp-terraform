resource "google_compute_health_check" "https_health_check" {
  name               = "${var.instance_group_name}-health-check"
  check_interval_sec = 120
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2
  http_health_check {
    port = 443
    request_path = "/"
    response = "Healthy"
  }
}

resource "google_compute_instance_group_manager" "this" {
  name               = var.instance_group_name
  base_instance_name = var.template_name
  #instance_template  = google_compute_instance_template.this.id
  zone               = var.zone
  version {
    name             = "${var.deploy_version}-${data.local_file.stdout.content}" 
    instance_template  = google_compute_instance_template.this.id
      }
  target_size        = 2
  named_port {
    name = "https"
    port = 443
  }
  auto_healing_policies {
    health_check   = google_compute_health_check.https_health_check.self_link
    initial_delay_sec = 300
  }
}
