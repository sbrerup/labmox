output "user_data_file_id" {
  description = "The full ID of the user data uploaded snippet file (e.g., 'local:snippets/user-data-k3s-server-01.yaml')."
  value       = proxmox_virtual_environment_file.user_data.id
}

output "user_data_file_name" {
  description = "The generated name of the user data file."
  value       = proxmox_virtual_environment_file.user_data.source_raw[0].file_name
}

output "network_data_file_id" {
  description = "The full ID of the network data uploaded snippet file (e.g., 'local:snippets/network-data-k3s-server-01.yaml')."
  value       = proxmox_virtual_environment_file.network_data.id
}

output "network_data_file_name" {
  description = "The generated name of the network data file."
  value       = proxmox_virtual_environment_file.network_data.source_raw[0].file_name
}
