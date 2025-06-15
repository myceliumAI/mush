#!/bin/bash
set -e

sudo apt-get update -y
sudo apt-get install -y curl

# Install k3s server
curl -sfL https://get.k3s.io | sh -

# Save the join token for agents
sudo cat /var/lib/rancher/k3s/server/node-token > /tmp/k3s_token

gcloud secrets versions add "${secret_name}" --data-file=/tmp/k3s_token --project="${project_id}" 

# ===== Prépare kubeconfig et l’envoie dans Secret Manager =====
INTERNAL_IP=$(curl -s -H "Metadata-Flavor: Google" \
              http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip)

sudo sed -e "s/127.0.0.1/${INTERNAL_IP}/" \
         /etc/rancher/k3s/k3s.yaml > /tmp/kubeconfig

# Charge comme nouvelle version chiffrée (le secret existe déjà grâce à TF)
gcloud secrets versions add "${kubeconfig_secret_name}" \
      --data-file=/tmp/kubeconfig \
      --project="${project_id}"