provider "google" {
  project     = var.project
  region      = var.region
  credentials = file("service-account.json")
}

data "google_compute_network" "default" {
  name = "default"
}

resource "google_storage_bucket" "remote-backend" {
  project                     = var.project
  name                        = bobko-diplom
  uniform_bucket_level_access = true
  location                    = var.region

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_iam_member" "remote" {
  bucket = google_storage_bucket.remote-backend.name
  role   = "roles/storage.admin"
  member = "serviceAccount:github-action-diplom@singular-glow-405611.iam.gserviceaccount.com"
}

