variable "name" {
  description = "Name of the cluster (used for resources)"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

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

variable "startup_script" {
  description = "Startup script for K3s installation"
  type        = string
  default     = ""
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