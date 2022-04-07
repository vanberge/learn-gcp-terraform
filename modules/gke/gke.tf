resource "google_container_cluster" "cluster" {
  name               = "k8s-cluster-01"
  network            = var.k8s_network
  subnetwork         = var.k8s_network_subnet
  initial_node_count = 1
  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-network-pod-range"
    services_secondary_range_name = "k8s-network-svc-range"
  }
}