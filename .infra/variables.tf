variable "project" {
  default = "singular-glow-405611"
}

variable "region" {
  default = "us-central1"
}

variable "storage_class" {
  default = "STANDARD"
}

variable "cluster_name" {
  description = "The name of the GKE Autopilot cluster"
  default     = "autopilot-cluster-bobko"
}
