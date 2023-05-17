### Version Code resource block start###

resource "null_resource" "std" {
  triggers = { always_run = "${timestamp()}"}
 provisioner "local-exec" {
   
     interpreter = ["/bin/bash", "-c"]
    #interpreter = ["powershell", "-command"]
     command = "git rev-parse --short HEAD|tr -d '\n' > ${path.root}/stdout.txt"
    #command = "git rev-parse --short HEAD | ForEach-Object { $_ -replace '\n', '' } | Out-File -FilePath ./stdout.txt -Encoding ascii"
    # command = " sh version.sh > ${path.root}/stdout.txt"
  }

}

data "local_file" "stdout" {
  filename = "${path.root}/stdout.txt"
 depends_on = [null_resource.std]
}

output "shell_stdout" {
 value = "${data.local_file.stdout.content}"
}
## Version Code resource block start###

resource "google_compute_instance_template" "wa-instance-temp" {
  name         = "${var.wa-it}-${data.local_file.stdout.content}"
  description = "instance template for workover analytics instance template"
  tags = "${var.tags}"

  labels = {
    service = "${var.wa-it}"
    version = "${var.deploy_version}-${data.local_file.stdout.content}"
  }

  metadata = {
    version = "${var.deploy_version}-${data.local_file.stdout.content}"
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
    email  = "secret-manager-account@testing-project-371619.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  #tags = "backend-api-instance-template"
  lifecycle {
    create_before_destroy = true
  }

}
