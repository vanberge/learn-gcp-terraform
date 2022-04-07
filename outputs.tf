output "vm_name" {
  value = module.instances.vm_name
}

output "vm_ip" {
  value = module.instances.vm_ip
}

output "vpc_network" {
  value = module.network.vpc_network
}

output "k8s_network" {
  value = module.network.k8s_network
}

output "k8s_cluster_name" {
  value = module.gke.k8s_cluster_name
}

output "gcs_bucket" {
  value = module.storage.gcs_bucket
}