output "template_self_link" {
  description = "Self link of the created instance template"
  value       = google_compute_instance_template.this.self_link
}

output "instance_group_self_link" {
  description = "Self link of the created managed instance group"
  value       = google_compute_region_instance_group_manager.this.self_link
}

output "master_instance_name" {
  description = "Name of the master instance (first node in the group)"
  value       = "${var.name}-0"
} 