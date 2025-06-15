#!/bin/bash

# Update system
apt-get update

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/

# Install Juju
snap install juju --classic

# Install Juju plugins
juju plugins install all

# --- Récupère kubeconfig en mémoire, le décode et le place avec perms strictes
gcloud secrets versions access latest \
  --secret="${kubeconfig_secret_name}" \
  --project="${project_id}" > /home/ubuntu/kubeconfig

chmod 600 /home/ubuntu/kubeconfig
export KUBECONFIG=/home/ubuntu/kubeconfig

# Configure Juju to use K3S
juju add-k8s my-k3s-cloud --kubeconfig $KUBECONFIG

# Add models
juju add-model kubeflow my-k3s-cloud

# Deploy models
juju deploy kubeflow --trust


