resource "google_compute_autoscaler" "wa-autoscaler" {
  name   = "wa-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.wa-instance-grp-manager.id

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = var.minimum_vm_size
    cooldown_period = 30

    cpu_utilization {
      target = 0.8
    }
  }

  depends_on = [ google_compute_instance_group_manager.wa-instance-grp-manager ]
}
