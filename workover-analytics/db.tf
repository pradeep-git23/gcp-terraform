resource "google_sql_database_instance" "postgres_instance" {
  name             = "${var.dbinstancename}"
  database_version = "${var.dbversion}"

  settings {
    tier = "db-f1-micro"
	ip_configuration {
		 ipv4_enabled        = false
		 private_network     = "projects/var.project/global/networks/default"
    }
  }
}

resource "google_sql_database" "my_database" {
  name     = "${var.dbname}"
  instance = google_sql_database_instance.postgres_instance.name
}

resource "google_sql_user" "my_user" {
  name     = "${var.username}"
  password = "${var.password}"
  instance = google_sql_database_instance.postgres_instance.name

  depends_on = [google_sql_database.my_database]
}

##Variable
variable "dbinstancename" {
  description = "Name of the PostgreSQL database instance"
  default     = "postgres-instance"
}
variable "dbversion" {
  description = "Version of PostgreSQL database"
  default     = "POSTGRES_14"
}
variable "dbname" {
  description = "Name of the PostgreSQL database"
  default     = "PostgreSQL-database"
}
variable "username" {
  description = "Username for the PostgreSQL user"
  default     = "mekidb"
}
variable "password" {
  description = "Password for the PostgreSQL user"
  default     = "$tr0ng123"
}
