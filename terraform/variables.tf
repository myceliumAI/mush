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

variable "kubeconfig_secret_name" {
  description = "Name of the Secret Manager secret where the K3s kubeconfig will be stored"
  type        = string
  default     = "k3s-kubeconfig"
}