terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.66.0"
    }
    
    google-beta = {
      source = "hashicorp/google-beta"
      version = "3.66.0"
    }
  }

 # required_version = "~> 0.15"
  required_version = "~> v1.4.2"
 backend "gcs" {
   bucket  = "tfstatefile"
   prefix  = "{vvar.loadbalancer_name}.tfstate"
 }
}
provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}
