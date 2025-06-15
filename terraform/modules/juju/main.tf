// Module to create a GCP K3s cluster (instance template + managed instance group)

# Bastion host: static VM instance running juju
resource "google_compute_instance" "juju_bastion" {
  name         = "juju-bastion"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = templatefile("${path.module}/scripts/startup-bastion.tpl", {
    project_id             = var.project_id
    kubeconfig_secret_name = var.kubeconfig_secret_name
  })

  tags = ["juju-bastion"]

  service_account {
    email  = google_service_account.juju_bastion.email
    scopes = ["cloud-platform"]
  }
}

# Service account for the Juju bastion host
resource "google_service_account" "juju_bastion" {
  account_id   = var.juju_service_account_name
  display_name = "Juju Bastion Service Account"
}

