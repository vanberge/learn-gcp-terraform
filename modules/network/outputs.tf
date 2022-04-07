output "vpc_network" {
  value = google_compute_network.vpc_network.name
}

output "k8s_network" {
  value = google_compute_network.k8s_network.name
}

output "k8s_network_subnet" {
  value = google_compute_subnetwork.k8s_network_subnet.name
}