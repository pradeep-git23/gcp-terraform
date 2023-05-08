resource "google_redis_instance" "redis" {
  name               = "my-redis-instance"
  tier               = "BASIC"
  memory_size_gb     = 1
  authorized_network = "default"
  redis_version      = "REDIS_6_0"

  # Connect instance to instance groups
  connect_mode = "DIRECT_PEERING"

}
