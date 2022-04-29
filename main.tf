terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.16.0"
    }
    random = {
      source  = "hashicorp/random" #let's use random things for scale
      version = "3.1.2"
    }
  }
}
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

#Start with modules for Network and VMs
module "network" {
  source = "./modules/network"
}
module "instances" {
  source      = "./modules/instances"
  vpc_network = module.network.vpc_network #Enable the vpc to be passed to the instances module
}

#Add Modules for GKE and storage
#module "gke" {
#  source             = "./modules/gke"
#  k8s_network        = module.network.k8s_network #Enable the vpc and subnet to be passed to the k8s module
#  k8s_network_subnet = module.network.k8s_network_subnet
#}
#module "storage" {
#  source     = "./modules/storage"
#  project_id = var.project_id #Pass project id into the storage module
#}