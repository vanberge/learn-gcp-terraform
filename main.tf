terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.16.0"
    }
  }
}
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "networks"{
  source  = "./modules/networks"
}

module "instances"{
  source  = "./modules/instances"
}

#module "storage"{
#  source  = "./modules/networks"
#}