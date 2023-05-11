resource "google_compute_instance_template" "ba-instance-temp" {
  name         = "ba-instance-temp"
  description = "instance template for backend api instance template"
  tags = "${var.tags}"

  labels = {
    service = "ba-instance-temp"
    version = "v1"
  }

  metadata = {
    version = "v1"
    block-project-ssh-keys = false
  }

  instance_description    = "This template is created for Backend api instance group redis"
  machine_type            = "e2-medium"
  can_ip_forward          = false
  metadata_startup_script = "${file("./startup/script.sh")}"

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = var.image
    boot         = true
    disk_type    = "pd-balanced"
  }

  network_interface {
    network = "default"

    access_config {
      network_tier = "PREMIUM"

    }

  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope a                                                      nd permissions granted via IAM Roles.
    email  = "13671140023-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  #tags = "backend-api-instance-template"
  lifecycle {
    create_before_destroy = true
  }

}
