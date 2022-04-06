output "vm_name" {
  value = google_compute_instance.vm_instance.hostname
}

output "vm_ip" {
  value = google_compute_instance.vm_instance.network_interface.0.network_ip
}