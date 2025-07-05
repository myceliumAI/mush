output "bastion_instance_name" {
  description = "Name of the Juju bastion instance"
  value       = google_compute_instance.juju_bastion.name
}

output "bastion_instance_ip" {
  description = "External IP of the Juju bastion instance"
  value       = google_compute_instance.juju_bastion.network_interface[0].access_config[0].nat_ip
}
