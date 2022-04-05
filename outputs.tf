output "vm name"{
    value = google_compute_instance.vm_instance.hostname
}

output "vm ip" {
  value = google_compute_instance.vm_instance.network_interface.0.network_ip
}

