// Module to create a GCP K3s cluster (instance template + managed instance group)

# Render master startup script
locals {
  master_startup_script = templatefile("${path.module}/scripts/startup-master.tpl", {
    project_id             = var.project_id
    k3s_token_secret_name  = var.k3s_token_secret_name
    kubeconfig_secret_name = var.kubeconfig_secret_name
  })
}

# Render agent startup script
locals {
  agent_startup_script = templatefile("${path.module}/scripts/startup-agent.tpl", {
    project_id            = var.project_id
    k3s_token_secret_name = var.k3s_token_secret_name
    master_ip             = google_compute_instance.k3s_master.network_interface[0].network_ip
  })
}

# Master node: static VM instance running k3s server
resource "google_compute_instance" "k3s_master" {
  name         = "${var.name}-master"
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

  metadata_startup_script = local.master_startup_script

  tags = ["k3s", "k3s-master", "mush"]

  service_account {
    email  = google_service_account.k3s_nodes.email
    scopes = ["cloud-platform"]
  }
}

# Agent node template: used by the MIG to create k3s agent nodes
resource "google_compute_instance_template" "k3s_agent_template" {
  name_prefix  = "${var.name}-agent-template-"
  machine_type = var.machine_type
  region       = var.region

  disk {
    source_image = var.image
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"
  }

  metadata_startup_script = local.agent_startup_script

  tags = ["k3s", "k3s-agent", "mush"]

  service_account {
    email  = google_service_account.k3s_nodes.email
    scopes = ["cloud-platform"]
  }

  lifecycle {
    # create a new template before destroying the old one
    create_before_destroy = true
  }
}

# Managed Instance Group (MIG) for k3s agent nodes
resource "google_compute_region_instance_group_manager" "k3s_agents" {
  name               = "${var.name}-agents-mig"
  region             = var.region
  base_instance_name = "${var.name}-agent"

  version {
    instance_template = google_compute_instance_template.k3s_agent_template.self_link
  }

  update_policy {
    type                  = "PROACTIVE"
    minimal_action        = "RESTART"
    max_unavailable_fixed = 3
  }
}

# Autoscaler for the agent MIG, controls min/max agent count
resource "google_compute_region_autoscaler" "this" {
  name   = "${var.name}-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.k3s_agents.id

  autoscaling_policy {
    min_replicas    = var.min_size
    max_replicas    = var.max_size
    cooldown_period = 60
    cpu_utilization {
      target = 0.6
    }
  }
}

