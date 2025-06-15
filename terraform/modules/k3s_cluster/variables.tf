# =========================
# Required Variables
# =========================

variable "name" {
  description = "Name of the cluster (used for resources)"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" {
  description = "GCP zone (for master node)"
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
  description = "Machine type for the nodes (e.g. e2-medium)"
  type        = string
  default     = "e2-medium"
}

variable "image" {
  description = "Image to use for the nodes (e.g. ubuntu-os-cloud/ubuntu-2204-lts)"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "min_size" {
  description = "Minimum number of instances in the group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the group"
  type        = number
  default     = 5
}

variable "k3s_secret_name" {
  description = "Name of the k3s join token secret in Secret Manager"
  type        = string
  default     = "k3s-join-token"
}

variable "k3s_service_account_name" {
  description = "Name of the service account for k3s nodes"
  type        = string
  default     = "k3s-nodes-sa"
} 