#Bring in hashi/random for scaling and randomizing names.  Use pets!
resource "random_pet" "petname" {}

#Create the VM attached to the network we just created
resource "google_compute_instance" "vm_instance" {
  #name         = "terraform-instance"
  name          = format("%s-%s", var.base_name,random_pet.petname.id)
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = var.vpc_network
    access_config {
      #External IP address
    }
  }
  #Uncomment if you wish to tag your VM 
  tags = ["web", "dev"]
}