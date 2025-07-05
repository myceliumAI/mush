# K3s internal firewall
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

# K3s cluster
module "k3s_cluster" {
  source     = "./modules/k3s_cluster"
  name       = "k3s-cluster"
  region     = var.region
  zone       = var.zone
  project_id = var.project_id
}

# Juju bastion (deploys after k3s cluster since it depends on cluster outputs)
module "juju_bastion" {
  source                 = "./modules/juju"
  name                   = "juju-bastion"
  zone                   = var.zone
  project_id             = var.project_id
  kubeconfig_secret_name = module.k3s_cluster.kubeconfig_secret_name
  kubeconfig_secret_id   = module.k3s_cluster.kubeconfig_secret_id
  depends_on             = [module.k3s_cluster]
}

# Cloud Router for NAT
resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  network = "default"
  region  = var.region
}

# Cloud NAT Gateway for all subnets in the region
resource "google_compute_router_nat" "nat_gw" {
  name                               = "nat-gateway"
  router                             = google_compute_router.nat_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}