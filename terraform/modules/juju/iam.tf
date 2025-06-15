# IAM binding: allow Juju bastion to read compute resources
resource "google_project_iam_member" "juju_bastion_compute_viewer" {
  project = var.project_id
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.juju_bastion.email}"
}

resource "google_secret_manager_secret_iam_member" "juju_kubeconfig_accessor" {
  secret_id = var.kubeconfig_secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.juju_bastion.email}"
}