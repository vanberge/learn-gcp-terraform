#Create the default VPC network 
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}