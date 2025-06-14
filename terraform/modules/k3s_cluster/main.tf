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
}

resource "google_compute_region_autoscaler" "this" {
  name   = "${var.name}-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.this.id

  autoscaling_policy {
    min_replicas = var.min_size
    max_replicas = var.max_size
    cooldown_period     = 60
    cpu_utilization {
      target = 0.6
    }
  }
} 