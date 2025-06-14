# Terraform Module: k3s_cluster

This module creates a Google Compute Engine Managed Instance Group (MIG) and its instance template, ready to be used as a K3s cluster on GCP.

## Features
- Creates an instance template with a custom startup script for K3s installation
- Deploys a managed instance group (MIG) using this template
- Allows configuration of node count, machine type, image, and more

## Variables
- `name`: Name of the cluster (used for resources)
- `region`: GCP region
- `machine_type`: Machine type (default: e2-medium)
- `image`: Image to use (default: debian-cloud/debian-11)
- `startup_script`: Startup script to install K3s (optional)

## Outputs
- `instance_group_self_link`: Self link of the created instance group
- `template_self_link`: Self link of the created instance template

## Usage example
```hcl
module "k3s_cluster" {
  source         = "./modules/k3s_cluster"
  name           = "k3s-cluster"
  region         = var.region
  machine_type   = "e2-medium"
  image          = "debian-cloud/debian-11"
  startup_script = file("${path.module}/startup.sh")
}
``` 