module "k3s_cluster" {
  source        = "./modules/k3s_cluster"
  name          = "k3s-cluster"
  region        = var.region
  # Add other variables as needed (e.g., node count, startup script)
}
