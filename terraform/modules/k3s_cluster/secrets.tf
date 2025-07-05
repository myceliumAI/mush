# Secret Manager secret for the k3s join token
resource "google_secret_manager_secret" "k3s_token" {
  secret_id = var.k3s_token_secret_name
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret" "k3s_kubeconfig" {
  secret_id = var.kubeconfig_secret_name
  replication {
    auto {}
  }
}