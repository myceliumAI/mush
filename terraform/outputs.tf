output "project_id" {
  value = var.project_id
  description = "GCP project ID used"
}

output "master_instance_name" {
  value = module.k3s_cluster.master_instance_name
}

output "instance_group_self_link" {
  value = module.k3s_cluster.instance_group_self_link
}

output "template_self_link" {
  value = module.k3s_cluster.template_self_link
}

