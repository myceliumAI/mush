#!/bin/bash
set -euo pipefail

###############################################################################
# 0. System prerequisites
###############################################################################
apt-get update -y
apt-get install -y dbus-x11
curl -fsSL "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  -o /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl
snap install juju --classic --channel=2.9/stable
###############################################################################
# 1. Wait for kubeconfig secret to be available in Secret Manager
###############################################################################
for i in {1..30}; do
  if gcloud secrets versions access latest --secret="${kubeconfig_secret_name}" --project="${project_id}" > /dev/null 2>&1; then
    echo "✅ kubeconfig secret is available"
    break
  else
    echo "❎ Waiting for kubeconfig secret to be available... ($i/30)"
    sleep 10
  fi
done

# Final check and fail gracefully if still not available
if ! gcloud secrets versions access latest --secret="${kubeconfig_secret_name}" --project="${project_id}" > /dev/null 2>&1; then
  echo "❌ kubeconfig secret was not available after waiting. Exiting."
  exit 1
fi

###############################################################################
# 2. kubeconfig: retrieve from Secret Manager and place in /home/ubuntu/.kube/config
###############################################################################
gcloud secrets versions access latest \
      --secret="${kubeconfig_secret_name}" \
      --project="${project_id}" \
      > /tmp/kcfg

mkdir -p /home/ubuntu/.kube                        # create directory if it does not exist
install -o ubuntu -g ubuntu -m600 -D /tmp/kcfg /home/ubuntu/.kube/config

###############################################################################
# 2b. Wait for Kubernetes API to be ready
###############################################################################
for i in {1..30}; do
  if sudo -u ubuntu KUBECONFIG=/home/ubuntu/.kube/config kubectl version; then
    echo "✅ Kubernetes API is ready"
    break
  else
    echo "❎ Waiting for Kubernetes API to be ready... ($i/30)"
    sleep 10
  fi
done

###############################################################################
# 3. Juju block — must be run as 'ubuntu'
###############################################################################
echo "💡 This script assumes a clean slate and will set up the Juju controller and models."
sudo -Hu ubuntu bash <<'EOSCRIPT'
set -eo pipefail
export KUBECONFIG=$HOME/.kube/config
eval "$(dbus-launch --exit-with-session)"

# Add k8s cloud
juju add-k8s mush-k3s-cloud --client

# Bootstrap a fresh controller
juju bootstrap mush-k3s-cloud mush-k3s-controller --debug --config controller-service-type=NodePort

# Add model
juju add-model mush-kubeflow mush-k3s-cloud

# Deploy Kubeflow
juju deploy kubeflow --channel=1.7/stable --trust
EOSCRIPT


