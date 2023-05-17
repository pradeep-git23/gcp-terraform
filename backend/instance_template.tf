
#### data ###

data "google_compute_network" "network" {
  name = "default"
}

data "google_compute_subnetwork" "subnet" {
  name   = "default"
  region = "us-central1"
}
### Version Code ###

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

#######

resource "google_compute_instance_template" "this" {
  name         = "${var.template_name}-${data.local_file.stdout.content}" 
  description = var.instance_template_description
  tags = var.tags

  labels = {
    service = "${var.template_name}"
     version = "${var.deploy_version}-${data.local_file.stdout.content}"
  }

  metadata = {
    version = "${var.deploy_version}-${data.local_file.stdout.content}"
    block-project-ssh-keys = false
  }

  instance_description    = var.instance_description
  machine_type            = var.machine_type
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
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "secret-manager-account@testing-project-371619.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }

}

####### Output Instance template ####

output "template_name" {
 value = google_compute_instance_template.this.name
}

output "label_version" {
 value = google_compute_instance_template.this.labels.version
}

output "metatdata_version" {
 value = google_compute_instance_template.this.metadata.version
}
