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

    # Install Zabbix agent
    wget https://repo.zabbix.com/zabbix/5.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.4-1+ubuntu20.04_all.deb
    sudo dpkg -i zabbix-release_5.4-1+ubuntu20.04_all.deb
    sudo apt-get update
    sudo apt-get install -y zabbix-agent
    SCRIPT
}
  
