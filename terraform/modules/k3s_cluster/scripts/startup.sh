#!/bin/bash

set -e

# Log to serial console for debugging
exec > >(tee /dev/console) 2>&1

# Install dependencies
sudo apt-get update -y
sudo apt-get install -y curl

# Get instance name
INSTANCE_NAME=$(curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/name)

# Define master node name (e.g., k3s-cluster-0)
MASTER_NAME="${INSTANCE_NAME%-*}-0"

if [[ "$INSTANCE_NAME" == "$MASTER_NAME" ]]; then
  echo "✅ This node is the master"
  curl -sfL https://get.k3s.io | sh -
  # Save the join token for agents
  cat /var/lib/rancher/k3s/server/node-token > /tmp/k3s_token
else
  echo "✅ This node is an agent"
  # Wait for master to be ready and get its IP
  MASTER_IP=$(getent hosts "$MASTER_NAME" | awk '{ print $1 }')
  while [[ -z "$MASTER_IP" ]]; do
    echo "❎ Waiting for master node DNS..."
    sleep 5
    MASTER_IP=$(getent hosts "$MASTER_NAME" | awk '{ print $1 }')
  done
  # Get the join token from metadata or a shared location (for demo, we fake it)
  # In production, use a GCS bucket or metadata server to share the token
  AGENT_TOKEN="REPLACE_WITH_TOKEN"
  curl -sfL https://get.k3s.io | K3S_URL="https://$MASTER_IP:6443" K3S_TOKEN="$AGENT_TOKEN" sh -
fi
