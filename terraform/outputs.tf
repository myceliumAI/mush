output "project_id" {
  value       = var.project_id
  description = "GCP project ID used"
}

output "agent_instance_group_self_link" {
  value = module.k3s_cluster.agent_instance_group_self_link
}

output "agent_template_self_link" {
  value = module.k3s_cluster.agent_template_self_link
}

output "master_instance_name" {
  value = module.k3s_cluster.master_instance_name
}

output "master_instance_ip" {
  value = module.k3s_cluster.master_instance_ip
}

