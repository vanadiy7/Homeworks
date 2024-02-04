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

resource "google_project_service" "gke" {
  project = var.project
  service = "container.googleapis.com"

  disable_dependent_services = true
}

resource "google_container_cluster" "autopilot" {
  depends_on = [google_project_service.gke]
  
  name       = var.cluster_name
  location   = var.region
  project    = var.project

  network    = google_compute_network.vpc.self_link
  subnetwork = google_compute_subnetwork.subnet.self_link

  cluster_autoscaling {
    auto_provisioning_defaults {
      service_account = google_service_account.cluster_sa.email
    }
  }
