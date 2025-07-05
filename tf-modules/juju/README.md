# Juju Bastion Terraform Module

Provision a lightweight Compute Engine VM on Google Cloud that acts as a *Juju* bastion host. The instance fetches a Kubernetes `kubeconfig` from Secret Manager at boot, allowing you to interact with your cluster through Juju.

## Features

- Creates a service account with minimum IAM permissions.
- Deploys a single VM instance with a configurable machine type and image.
- Injects a startup script that installs Juju and retrieves the `kubeconfig` secret.
- Exposes helpful outputs such as the instance name and public IP address.

## Usage

```hcl
module "juju_bastion" {
  source = "./tf-modules/juju" # adjust path as needed

  # Required variables
  name                  = "juju-bastion"
  zone                  = "europe-west1-b"
  project_id            = "my-gcp-project"
  kubeconfig_secret_id  = "projects/123456/secrets/k3s-kubeconfig"
  kubeconfig_secret_name = "k3s-kubeconfig"

  # Optional overrides
  machine_type              = "e2-small"   # default
  image                     = "ubuntu-os-cloud/ubuntu-2204-lts" # default
  juju_service_account_name = "juju-bastion-sa" # default
}
```

### Required Variables

| Name | Description |
|------|-------------|
| `name` | Name of the bastion VM (also used as the instance resource name). |
| `zone` | GCP zone where the VM will be created. |
| `project_id` | ID of the Google Cloud project. |
| `kubeconfig_secret_id` | Full resource ID of the Secret Manager secret containing your cluster kubeconfig. |
| `kubeconfig_secret_name` | Name of the secret (used inside the startup script). |

### Optional Variables

| Name | Default | Description |
|------|---------|-------------|
| `machine_type` | `e2-small` | Compute Engine machine type. |
| `image` | `ubuntu-os-cloud/ubuntu-2204-lts` | OS image for the bastion. |
| `juju_service_account_name` | `juju-bastion-sa` | Service account name for the bastion. |

## Outputs

| Output | Description |
|--------|-------------|
| `bastion_instance_name` | Name of the created VM instance. |
| `bastion_instance_ip`   | External IP address of the bastion. |

## Prerequisites

1. The default VPC **or** a suitable network route must allow SSH access.
2. The specified `kubeconfig_secret_id` must already exist in Secret Manager.
3. Terraform Google provider is configured and authenticated.

---
a© Dataplateform 