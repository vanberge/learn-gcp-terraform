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
module "network" {
  source = "./modules/network"
}
module "instances" {
  source      = "./modules/instances"
  vpc_network = module.network.vpc_network #Enable the vpc to be passed to the instances module
}
module "gke"{
  source  = "./modules/gke"
  k8s_network = module.network.k8s_network #Enable the vpc to be passed to the k8s module
  k8s_network_subnet= module.network.k8s_network_subnet
}
#module "storage"{
#  source  = "./modules/storage"
#}