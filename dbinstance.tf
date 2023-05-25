resource "google_compute_firewall" "firewall" {
  name    = "${var.dbfirewall}"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }
  source_ranges = ["0.0.0.0/0"] #
  target_tags   = ["dbfirewall"]
}

resource "google_compute_instance" "dev" {
  count        = {{count | int}}
  name         = "{{hostname}}${count.index}"
  machine_type = "{{machine_type}}"
  #zone         = "{{region}}-a"
  zone          = "{{zone}}"
  tags         = {{tags | union(["created-by","concierto",]) | replace("'",'"') | replace("u",'')}}
  boot_disk {
    initialize_params {
      image = "{{image}}"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.network-with-private-secondary-ip-ranges.id
    access_config {
        nat_ip = google_compute_address.static[count.index].address
     }
    }
  depends_on = [ google_compute_firewall.firewall]
}

