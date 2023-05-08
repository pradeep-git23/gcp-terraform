resource "google_redis_instance" "redis" {
  name               = "my-redis-instance"
  tier               = "STANDARD_HA"
  memory_size_gb     = 1
  authorized_network = "default"
  redis_version      = "REDIS_6_0"

  # Connect instance to instance groups
  connect_mode = "DIRECT_PEERING"
  
  # Instance managed group 1
  redis_configs {
    key   = "instance-group-1"
    value = google_compute_instance_group_manager.ba-instance-grp-manager.self_link
  }
}