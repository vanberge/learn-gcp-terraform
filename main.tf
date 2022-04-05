#Intro File. Simply create a GCP VM in the Default Network

resource "google_compute_instance" "terraform" {
  project      = "evb-gcp-terraform"
  name         = "terraform"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
  }
}
