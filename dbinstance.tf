##terraform block to create firewall for db instance
resource "google_compute_firewall" "firewall" {
  name    = "${var.dbfirewall}"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["dbfirewall"]
}

## Terraform block for db instance provisioning
resource "google_compute_instance" "db_instance" {
  name         = "${var.name}"
  machine_type = "${var.type}"
  zone         = "us-central1-a"

  tags = ["dbfirewall"]

  boot_disk {
    initialize_params {
      image = "${var.image}"
     }
  }
  metadata_startup_script = "${file("./startup/script.sh")}"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "secret-manager-account@testing-project-371619.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
  network_interface {
    network = "default"

 #   access_config {
 #     // Ephemeral public IP (will be used when you want to give static ip to instance)
 #   }
  }
  depends_on = [ google_compute_firewall.firewall]
}
