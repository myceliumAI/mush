# K3s Cluster Terraform Module

Provision a lightweight **K3s** Kubernetes cluster on Google Cloud composed of:

1. A **single master** Compute Engine VM running the K3s server.
2. A **managed instance group** of agent nodes that auto-scales based on CPU load.
3. A **service account** with the minimum IAM roles required.
4. **Secret Manager** secrets that hold the cluster join-token and exported kubeconfig.

## Features

- GPU-less, cost-effective K3s deployment (master + agents) on Compute Engine.
- Startup scripts install and configure K3s automatically.
- Auto-scaling agents (min/max sizes configurable).
- Secrets for join token and kubeconfig are created and permissions granted.
- Helpful outputs: master internal IP and kubeconfig secret references.

## Usage

```hcl
module "k3s_cluster" {
  source = "./tf-modules/k3s_cluster"  # adjust path if needed

  # Required variables
  name       = "demo-k3s"
  project_id = "my-gcp-project"
  region     = "europe-west1"
  zone       = "europe-west1-b"

  # Optional overrides
  machine_type             = "e2-medium"          # default
  min_size                 = 1                    # default
  max_size                 = 5                    # default
  k3s_token_secret_name    = "k3s-join-token"     # default
  kubeconfig_secret_name   = "k3s-kubeconfig"     # default
  k3s_service_account_name = "k3s-nodes-sa"       # default
}
```

### Required Variables

| Name | Description |
|------|-------------|
| `name` | Prefix for resources (used in instance names, MIG, etc.). |
| `region` | GCP region for agent MIG. |
| `zone` | GCP zone for the master node. |
| `project_id` | Google Cloud project ID. |

### Optional Variables

| Name | Default | Description |
|------|---------|-------------|
| `machine_type` | `e2-medium` | VM machine type for both master and agents. |
| `image` | `ubuntu-os-cloud/ubuntu-2204-lts` | OS image for all nodes. |
| `min_size` | `1` | Minimum number of agent nodes. |
| `max_size` | `5` | Maximum number of agent nodes. |
| `k3s_token_secret_name` | `k3s-join-token` | Secret ID for K3s cluster join token. |
| `kubeconfig_secret_name` | `k3s-kubeconfig` | Secret ID to store the cluster kubeconfig. |
| `k3s_service_account_name` | `k3s-nodes-sa` | Service account name for cluster nodes. |

## Outputs

| Output | Description |
|--------|-------------|
| `master_instance_name` | Name of the master VM instance. |
| `master_instance_ip`   | Internal IP address of the master. |
| `kubeconfig_secret_id` | Resource ID of the Secret Manager secret containing the kubeconfig. |
| `kubeconfig_secret_name` | Name of the kubeconfig secret (useful for scripts). |

## Prerequisites

1. Default VPC (or a custom one) must allow node-to-node traffic and master access.
2. Terraform Google provider configured and authenticated.
3. Compute Engine API & Secret Manager API enabled in the target project.

---
© Dataplateform 