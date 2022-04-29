#Create the default VPC network 
resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = true #Default vpc network, just auto-create all subs
}

resource "google_compute_network" "k8s_network" {
  name                    = "k8s-network"
  auto_create_subnetworks = false #Kubernetes specific, let's create subnets manually below
}

resource "google_compute_subnetwork" "k8s_network_subnet" {
  name          = "k8s-network-subnet" #primary subnet will be used for GKE hosts
  ip_cidr_range = "10.2.0.0/16"
  network       = google_compute_network.k8s_network.id

  secondary_ip_range {
    range_name    = "k8s-network-svc-range" #secondary range will be used for Kubernetes services
    ip_cidr_range = "192.168.10.0/24"
  }

  secondary_ip_range {
    range_name    = "k8s-network-pod-range" #last range will be used for pods, so is the largest
    ip_cidr_range = "192.168.96.0/21"
  }
}