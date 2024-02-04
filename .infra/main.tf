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

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_id
  name                       = var.name
  region                     = var.region
  zones                      = var.zones
  network                    = "default"
  subnetwork                 = "default"
  ip_range_pods              = ""
  ip_range_services          = ""
  http_load_balancing        = false
  network_policy             = true
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false

  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = var.machine_type
      node_locations            = "us-central1-b,us-central1-c"
      min_count                 = var.min_count
      max_count                 = var.max_count
      local_ssd_count           = var.disk_size_gb
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      auto_repair               = true
      auto_upgrade              = true
      service_account           = var.service_account
      preemptible               = false
      initial_node_count        = var.initial_node_count
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}
