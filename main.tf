terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.16.0"
    }
  }
}
provider "google" {
  project = "<PROJECT_ID>"
  region  = "us-central1"
  zone    = "us-central1-c"
}

#Create the default VPC network 
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

#Create the VM attached to the network we just created
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  #Uncomment if you wish to tag your VM 
  #tags        = ["web", "dev"]
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      #External IP address
    }
  }
}
