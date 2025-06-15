output "agent_template_self_link" {
  description = "Self link of the created agent instance template"
  value       = google_compute_instance_template.k3s_agent_template.self_link
}

output "agent_instance_group_self_link" {
  description = "Self link of the created managed instance group for agents"
  value       = google_compute_region_instance_group_manager.k3s_agents.self_link
}

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