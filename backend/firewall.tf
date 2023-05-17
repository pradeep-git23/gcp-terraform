resource "google_compute_firewall" "this" {
  name    = "${var.loadbalancer_name}-allow-healthcheck"
  network = data.google_compute_network.network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443" ]
     }
  
  priority = 1000
  #source_ranges = ["103.219.229.243/32"]
  source_ranges = ["35.191.0.0/16", "130.211.0.0/22", "0.0.0.0/0"]
  target_tags = var.tags
}
