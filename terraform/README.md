# Terraform Infrastructure for Mush

## Required IAM Roles

The service account (or user) running this Terraform stack must have the following roles on the target GCP project:

- `roles/compute.admin` — Full control of all Compute Engine resources
- `roles/editor` — View, create, update, and delete most Google Cloud resources
- `roles/secretmanager.admin` — Full access to administer Secret Manager resources
- `roles/iam.serviceAccountUser` — Run operations as the service account

> **Grant these roles with:**
> ```sh
> gcloud projects add-iam-policy-binding <PROJECT_ID> \
>   --member="serviceAccount:<SERVICE_ACCOUNT_EMAIL>" \
>   --role="roles/compute.admin"
> # ...repeat for each role
> ```

## Usage

Most useful commands are available via the provided `Makefile`:

- `make init` — Initialize Terraform
- `make plan` — Show the Terraform plan for the selected environment
- `make apply` — Apply the Terraform plan
- `make destroy` — Destroy the Terraform stack
- `make format` — Format and validate Terraform code


*Execute `make help` to see the full list*
