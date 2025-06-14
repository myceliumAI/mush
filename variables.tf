variable "project_id" {
  description = "ID du projet GCP"
  type        = string
}

variable "region" {
  description = "Région GCP"
  type        = string
}

variable "zone" {
  description = "Zone GCP"
  type        = string
}

variable "tf_service_account" {
  description = "Service account utilisé par Terraform"
  type        = string
} 