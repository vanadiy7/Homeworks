variable "project_id" {
  type        = string
  description = "The project ID to create the cluster."
}

variable "region" {
  type        = string
  description = "The region to create the cluster."
}

variable "zones" {
  type        = string
  description = "The zones to create the cluster."
}

variable "machine_type" {
  type        = string
  description = "Type of the node compute engines."
}
