resource "google_compute_firewall" "k3s_internal" {
  name    = "k3s-allow-internal"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["6443", "10250", "30000-32767"]
  }

  allow {
    protocol = "udp"
    ports    = ["8472"]
  }

  source_tags = ["k3s"]
  target_tags = ["k3s"]
  direction   = "INGRESS"
  priority    = 1000
  description = "Allow K3s internal cluster communication"
}

module "k3s_cluster" {
  source     = "./modules/k3s_cluster"
  name       = "k3s-cluster"
  region     = var.region
  zone       = var.zone
  project_id = var.project_id
}
