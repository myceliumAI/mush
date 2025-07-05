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

## Important: 

### Juju Redeployment

If you make changes to the Juju bastion module after it has already been applied, the Juju controller and resources in your cluster may already exist. Retrying an apply without resetting will cause Juju bootstrap or controller setup to fail.

To apply Juju-related changes safely:

1. Run `make destroy` to tear down the existing Terraform stack, including the k3s cluster contianing juju ressources.
2. Run `make apply` to recreate everything from scratch, ensuring a fresh Juju controller deployment in your cluster.
