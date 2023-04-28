variable "project" {
    type = string
    description = "Google Cloud Platform Project ID"
    default = "testing-project-371619" 
}

variable "region" {
    type = string
    description = "Infrastructure Region"
    default = "us-central1"
}

variable "project_name" {
    type = string
    description = "project-name"
    default = "testing-project"
}

variable "zone" {
    type = string
    description = "Zone"
    default = "us-central1-a"
}

variable "name" {
    type = string
    description = "The base name of resources"
    default = "instance-template-02"
}

variable "instance_group_name" {
    type = string
    description = "The base name of resources"
    default = "testing-animo-backend-group"
}

variable "loadbalancer_name" {
    type = string
    description = "The base name of resources"
    default = "testing-animo-backend-load-balancer"
}


variable "template_name" {
    type = string
    description = "The base name of resources"
    default = "testing-animo-backend-template-3-0-0"
}

variable "domain_name" {
    type = string
    description = "Valid Domain name"
    default = "animo-ap.pro"
}

variable "deploy_version" {
    type = string
    description = "Deployment Version"
    default = "v1"
}

#variable "image" {
#    type = string
#    description = "VM Image for Instance Template"
#    default = "debian-cloud/debian-11"
#}

variable "image" {
    type = string
    description = "VM Image for Instance Template"
    # default = "ubuntu-os-cloud/ubuntu-2204-lts"
    # default = "ubuntu-2204-lts-animo-backend"
    default = "animo-backend-image-poc"
}

variable "tags" {
    type = list
    description = "Network Tags for resources"
    default = [ "backend", "http-server", "https-server"]
}

variable "machine_type" {
    type = string
    description = "VM Size"
    default = "e2-medium"
}

variable "network" {
    type = string
    description = "Network Name"
    default = "default"
}

variable "subnet" {
    type = string
    description = "Subnet Name"
    default = "default"
}

variable "instance_description" {
    type = string
    description = "Description assigned to instances"
    default = "This template is used to create nginx-app server instances"
}

variable "instance_group_manager_description" {
    type = string
    description = "Description of instance group manager"
    default = "Instance group for nginx-app server"
}

variable "instance_template_description" {
    type = string
    description = "Description of instance template"
    default = "vm server template"
}

variable "minimum_vm_size" {
    type = number
    description = "Minimum VM size in Instance Group"
    default = 1
}
