provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
  impersonate_service_account = var.tf_service_account
} 