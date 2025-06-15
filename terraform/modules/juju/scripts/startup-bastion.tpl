#!/bin/bash
set -euo pipefail

###############################################################################
# 0. Pré-requis système (root)
###############################################################################
apt-get update -y
curl -fsSL "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  -o /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl
snap install juju --channel=3/stable      # strict ; pas besoin de --classic

###############################################################################
# 1. kubeconfig : on le récupère depuis Secret Manager et on le place dans
#    /home/ubuntu/.kube/config (on crée le chemin si nécessaire)
###############################################################################
gcloud secrets versions access latest \
      --secret="k3s-kubeconfig" \
      --project="delphaproduction" \
      > /tmp/kcfg

mkdir -p /home/ubuntu/.kube                        # si le dossier n'existe pas
install -o ubuntu -g ubuntu -m600 -D /tmp/kcfg /home/ubuntu/.kube/config

###############################################################################
# 2. Bloc Juju — obligatoirement sous 'ubuntu'
###############################################################################
sudo -Hu ubuntu bash -c '\
  set -euo pipefail; \
  export KUBECONFIG=$HOME/.kube/config; \
  eval "$(dbus-launch --exit-with-session)"; \
  juju add-k8s my-k3s-cloud --client || true; \
  if ! juju controllers --format=yaml | grep -q "^  my-k3s-controller:"; then \
       juju bootstrap my-k3s-cloud my-k3s-controller; \
  fi; \
  if ! juju models --format=short | awk "{print \$1}" | grep -Fxq kubeflow; then \
       juju add-model kubeflow my-k3s-cloud; \
  fi; \
  juju deploy kubeflow --trust || true \
'


