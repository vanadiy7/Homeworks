terraform {
  backend "gcs" {
    bucket      = "<bucket-name>"
    prefix      = "terraform/state"
    credentials = "./terraform-gke-keyfile.json"
  }
}
