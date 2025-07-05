output "project_id" {
  value       = var.project_id
  description = "GCP project ID used"
}

output "master_instance_name" {
  value = module.k3s_cluster.master_instance_name
}

output "master_instance_ip" {
  value = module.k3s_cluster.master_instance_ip
}

output "juju_bastion_instance_name" {
  value = module.juju_bastion.bastion_instance_name
}

output "juju_bastion_instance_ip" {
  value = module.juju_bastion.bastion_instance_ip
}
