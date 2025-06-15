# =========================
# Required Variables
# =========================

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" {
  description = "GCP zone (for bastion host)"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

# =========================
# Optional Variables
# =========================

variable "machine_type" {
  description = "Machine type for the bastion host (e.g. e2-small)"
  type        = string
  default     = "e2-small" # 2 vCPUs, 2 GB memory
}

variable "image" {
  description = "Image to use for the bastion host (e.g. ubuntu-os-cloud/ubuntu-2204-lts)"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "juju_service_account_name" {
  description = "Name of the service account for Juju bastion"
  type        = string
  default     = "juju-bastion-sa"
}

variable "kubeconfig_secret_id" {
  description = "ID of the Secret Manager secret that contains the cluster kubeconfig"
  type        = string
}

variable "kubeconfig_secret_name" {
  description = "Secret Manager secret name that stores the kubeconfig (used in startup script)"
  type        = string
} 