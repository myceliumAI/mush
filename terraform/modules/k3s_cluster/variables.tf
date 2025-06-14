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
  description = "Image to use for the nodes (e.g. debian-cloud/debian-11)"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "startup_script" {
  description = "Startup script for K3s installation"
  type        = string
  default     = ""
}

variable "target_size" {
  description = "Number of nodes in the cluster"
  type        = number
  default     = 3
} 