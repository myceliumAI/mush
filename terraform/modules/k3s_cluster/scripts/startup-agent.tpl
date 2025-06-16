#!/bin/bash
set -e

sudo apt-get update -y
sudo apt-get install -y curl

# Fetch the join token from Secret Manager
AGENT_TOKEN=$(gcloud secrets versions access latest --secret="${k3s_token_secret_name}" --project="${project_id}")

# Join the k3s cluster
curl -sfL https://get.k3s.io | K3S_URL="https://${master_ip}:6443" K3S_TOKEN="$AGENT_TOKEN" sh - 