terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = var.network
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "vm_instance" {
  name         = var.name
  machine_type = "n1-standard-1"
  zone         = var.zone
  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-20-04-lts
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.self_link
  }
  
  metadata = {
    ssh-keys = "ansible:<ssh-rsa ….>
  }
 
metadata_startup_script = <<SCRIPT
#!/bin/bash
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y ansible
SCRIPT
}
  
