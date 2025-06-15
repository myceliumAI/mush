
# IAM binding: allow k3s nodes to access the join token secret
resource "google_secret_manager_secret_iam_member" "nodes_access" {
  secret_id = google_secret_manager_secret.k3s_token.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.k3s_nodes.email}"
}

# IAM binding: allow k3s master to add new versions to the join token secret
resource "google_secret_manager_secret_iam_member" "nodes_add" {
  secret_id = google_secret_manager_secret.k3s_token.id
  role      = "roles/secretmanager.secretVersionAdder"
  member    = "serviceAccount:${google_service_account.k3s_nodes.email}"
}

# IAM binding: allow k3s master to add new versions to the kubeconfig secret
resource "google_secret_manager_secret_iam_member" "kubeconfig_adder" {
  secret_id = google_secret_manager_secret.k3s_kubeconfig.id
  role      = "roles/secretmanager.secretVersionAdder"
  member    = "serviceAccount:${google_service_account.k3s_nodes.email}"
}