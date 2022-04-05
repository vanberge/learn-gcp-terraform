#Create the VM attached to the network we just created
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      #External IP address
    }
  }
  #Uncomment if you wish to tag your VM 
  tags        = ["web", "dev"]
}