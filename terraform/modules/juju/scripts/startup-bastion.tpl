#!/bin/bash

set -e

# Update system and install dependencies
apt-get update -y

# Install kubectl (latest stable)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/

# Install Juju snap (strict confinement acceptable for headless usage)
snap install juju --classic

# -----------------------------------------------------------------------------
# Retrieve kubeconfig from Secret Manager and install it for the ubuntu user
# -----------------------------------------------------------------------------
# Fonction de récupération brute
fetch_kcfg() {
  gcloud secrets versions access latest \
    --secret="k3s-kubeconfig" \
    --project="delphaproduction"
}

# Attente tant que le kubeconfig n'est pas peuplé (présence du bloc clusters:)
until fetch_kcfg | tee /tmp/kcfg | grep -q "^clusters:"; do
  echo "⏳ kubeconfig pas encore disponible, nouvelle tentative dans 5 s…"
  sleep 5
done

# Installation dans le HOME de l'utilisateur ubuntu
chmod 600 /tmp/kcfg
mkdir -p /home/ubuntu/.kube
mv /tmp/kcfg /home/ubuntu/.kube/config
chown -R ubuntu:ubuntu /home/ubuntu/.kube

# Active une session systemd utilisateur persistante (bus D-Bus nécessaire à snap/juju)
loginctl enable-linger ubuntu || true

# -----------------------------------------------------------------------------
# Execute Juju commands under the unprivileged 'ubuntu' account
# -----------------------------------------------------------------------------
sudo -u ubuntu -i -- dbus-run-session -- bash <<'EOSU'
  set -e
  export KUBECONFIG="$HOME/.kube/config"

  # Déclare le cluster K3s à Juju (idempotent)
  juju add-k8s my-k3s-cloud --client

  # Initialise un contrôleur Juju sur le cluster (une seule fois)
  if ! juju controllers --format=yaml | grep -q "my-k3s-controller:"; then
    juju bootstrap --no-gui my-k3s-cloud my-k3s-controller
  fi

  # Crée le modèle Kubeflow et déploie le bundle (idempotent)
  juju add-model kubeflow my-k3s-cloud || true
  juju deploy kubeflow --trust || true
EOSU


