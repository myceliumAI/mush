
output "master_instance_name" {
  description = "Name of the master instance"
  value       = google_compute_instance.k3s_master.name
}

output "master_instance_ip" {
  description = "Internal IP of the master instance"
  value       = google_compute_instance.k3s_master.network_interface[0].network_ip
}

output "kubeconfig_secret_id" {
  description = "ID of the kubeconfig secret storing the kubeconfig for the cluster"
  value       = google_secret_manager_secret.k3s_kubeconfig.id
}

output "kubeconfig_secret_name" {
  description = "Name of the kubeconfig secret storing the kubeconfig for the cluster"
  value       = var.kubeconfig_secret_name
} 