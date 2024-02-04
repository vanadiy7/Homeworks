provider "google" {
  project     = var.project
  region      = var.region
  credentials = file("service-account.json")
}

data "google_compute_network" "default" {
  name = "default"
}

