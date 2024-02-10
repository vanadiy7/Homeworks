provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}

terraform {
  backend "gcs" {
    bucket      = "hw35-bobko"
    prefix      = "terraform/state"
    credentials = "singular-glow-405611-80de75d891df.json"
  }
}
resource "google_compute_instance" "myinstance" {
  for_each     = toset(var.zone)
  name         = "myinstance-${each.key}"
  machine_type = var.machine_type
  zone         = each.key

  network_interface {
    network = "default"
    dynamic "access_config" {
      for_each = var.enable_public_ip == false ? [] : ["Public IP"]
      content {
      }
    }
  }

  boot_disk {
    initialize_params {
      image = data.google_compute_image.image.self_link
    }
  }
  depends_on = [time_sleep.delay]
}

resource "time_sleep" "delay" {
  create_duration = "30s"
}

output "ip_addresses" {
  value     = join(", ", [for instance in google_compute_instance.myinstance : instance.network_interface[0].access_config[0].nat_ip])
  sensitive = false
}

resource "null_resource" "stop_vms" {
  for_each   = toset(var.zone)
  depends_on = [google_compute_instance.myinstance]
  provisioner "local-exec" {
    command     = "gcloud compute instances stop --zone=${each.key} myinstance-${each.key}"
    interpreter = ["/bin/bash", "-c"]
  }
}

data "google_compute_image" "image" {
  family  = var.image_family
  project = var.image_project
}

data "http" "current_ip" {
  url = "https://ipinfo.io/ip"
}

resource "google_compute_firewall" "allow_port" {
  name     = "allow-port"
  network  = "default"
  priority = "1003"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["${chomp(data.http.current_ip.response_body)}/32"]
}
