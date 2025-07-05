// Module to create a GCP Juju bastion host

# Render juju startup script
locals {
  juju_startup_script = templatefile("${path.module}/scripts/startup-bastion.tpl", {
    project_id             = var.project_id
    kubeconfig_secret_name = var.kubeconfig_secret_name
  })
}

# Bastion host: static VM instance running juju
resource "google_compute_instance" "juju_bastion" {
  name         = var.name
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

  metadata_startup_script = local.juju_startup_script

  tags = ["juju", "mush"]

  service_account {
    email  = google_service_account.juju_bastion.email
    scopes = ["cloud-platform"]
  }
}


