# Deploying a K3s Cluster on GCP with Terraform

## Project Structure

```
modules/                 # Reusable modules (instance_template, mig, etc.)
environments/            # Environment-specific variables (prod, dev, ...)
main.tf                  # Main entry point
provider.tf              # GCP provider configuration
variables.tf             # Global variable declarations
outputs.tf               # Project outputs
versions.tf              # Version constraints
```

## Quick Start

1. Fill in your variables in `environments/prod.tfvars`.
2. Initialize the project:
   ```bash
   terraform init
   ```
3. Run the plan:
   ```bash
   terraform plan -var-file="environments/prod.tfvars"
   ```
4. Apply:
   ```bash
   terraform apply -var-file="environments/prod.tfvars"
   ```

## Coming Soon
- Modules for the instance template, MIG, and K3s installation.
- Automatic kubeconfig generation to connect to the cluster. 