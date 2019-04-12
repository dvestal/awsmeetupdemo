provider "google" {
  project = "awsmeetupdemo"
  region  = "us-central1"
  zone    = "us-central1-c"
  version = "~> 2.1"
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  metadata {
    ssh-keys = "${var.gce_ssh_user}:${var.ssh_key}"
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "${google_compute_network.vpc_network.self_link}"
    access_config = {}
  }
}

resource "google_compute_firewall" "allow-bastion" {
  name    = "demo-fw-allow-bastion"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow-http" {
  name    = "demo-fw-allow-http"
  network = "${google_compute_network.vpc_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}
