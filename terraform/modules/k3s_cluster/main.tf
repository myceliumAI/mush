// Module to create a GCP K3s cluster (instance template + managed instance group)

resource "google_compute_instance_template" "this" {
  name           = "${var.name}-template"
  machine_type   = var.machine_type
  region         = var.region

  disk {
    source_image = var.image
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = var.startup_script

  tags = ["k3s"]
}

resource "google_compute_region_instance_group_manager" "this" {
  name               = "${var.name}-mig"
  region             = var.region
  base_instance_name = var.name
  version {
    instance_template = google_compute_instance_template.this.self_link
  }
  target_size        = var.target_size
  auto_healing_policies {
    health_check      = null
    initial_delay_sec = 300
  }
} 