# =========================
# Required Variables
# =========================

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" {
  description = "GCP zone"
  type        = string
}

variable "tf_service_account" {
  description = "Service account used by Terraform"
  type        = string
}



# =========================
# Optional Variables
# =========================