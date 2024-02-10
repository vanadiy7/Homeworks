variable "project" {
  description = "Project"
  default     = "singular-glow-405611"
}
variable "credentials" {
  default = "singular-glow-405611-80de75d891df.json"
}
variable "machine_type" {
  default = "e2-medium"
}
variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = ["us-central1-a", "us-central1-b", "us-central1-c"]
}
variable "enable_public_ip" {
  default = true
}
variable "image_family" {
  default = "debian-12"
}
variable "image_project" {
  default = "debian-cloud"
}
