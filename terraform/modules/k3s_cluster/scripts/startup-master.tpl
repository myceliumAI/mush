#!/bin/bash
set -e

sudo apt-get update -y
sudo apt-get install -y curl

# Install k3s server
curl -sfL https://get.k3s.io | sh -

# Save the join token for agents
cat /var/lib/rancher/k3s/server/node-token > /tmp/k3s_token

gcloud secrets versions add "${secret_name}" --data-file=/tmp/k3s_token --project="${project_id}" 