variable "project" {
    type = string
    description = "Google Cloud Platform Project ID"
    default = "project02-373018"
}

variable "region" {
    type = string
    description = "Infrastructure Region"
    default = "us-central1"
}

variable "project_name" {
    type = string
    description = "project-name"
    default = "project02"
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
    default = "ubuntu-os-cloud/ubuntu-2204-lts"
    # default = "ubuntu-2204-lts-animo-backend"
   # default = "animo-backend-image-poc"
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
    default = "This template is used to create nginx-app server instances in gcp"
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

variable "lb_name" {
    type = string
    description = "Description of instance template"
    default = "wa-load-balancer"
}
