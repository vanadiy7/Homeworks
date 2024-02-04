provider "google" {
  project     = var.project
  region      = var.region
  credentials = file("service-account.json")
}

data "google_compute_network" "default" {
  name = "default"
}

terraform {
  backend "gcs" {
    bucket      = "bobko-diplom"
    prefix      = "terraform/state"
    credentials = "service-account.json"
  }
}
resource "google_artifact_registry_repository" "my_repository" {
  provider      = google
  location      = var.region
  repository_id = "bobko-diplom"
  description   = "My repository"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository_iam_member" "member" {
  provider   = google
  repository = google_artifact_registry_repository.my_repository.bobko-diplom
  role       = "roles/artifactregistry.admin"
  member     = "serviceAccount:github-action-diplom@singular-glow-405611.iam.gserviceaccount.com"
}
