# Terraform Infrastructure for Mush

## Requirements

### IAM Roles
The service account (or user) running this Terraform stack must have the following roles on the target GCP project:

- `roles/compute.admin` — Full control of all Compute Engine resources
- `roles/editor` — View, create, update, and delete most Google Cloud resources
- `roles/secretmanager.admin` — Full access to administer Secret Manager resources
- `roles/iam.serviceAccountUser` — Run operations as the service account


## Usage

Most useful commands are available via the provided `Makefile`:

- `make init` — Initialize Terraform
- `make plan` — Show the Terraform plan for the selected environment
- `make apply` — Apply the Terraform plan
- `make destroy` — Destroy the Terraform stack
- `make format` — Format and validate Terraform code

*Execute `make help` to see the full list*
