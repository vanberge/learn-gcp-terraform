terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.16.0"
    }
  }
}
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

#Modules for Network, VMs, and Storage bucket
module "networks" {
  source = "./modules/network"
}
module "instances" {
  source      = "./modules/instances"
  vpc_network = module.networks.vpc_network #Enable the vpc to be passed to the instances module
}
#module "storage"{
#  source  = "./modules/networks"
#}