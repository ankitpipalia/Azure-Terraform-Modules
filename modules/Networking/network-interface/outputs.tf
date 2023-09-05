output "id" {
  description = "The ID of the network interface"
  value       = azurerm_network_interface.nic.id
}

output "network_interface_private_ip" {
  description = "The private IP address of the network interface"
  value       = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
}

output "network_interface_public_ip" {
  description = "The public IP address of the network interface"
  value       = azurerm_network_interface.nic.ip_configuration[0].public_ip_address_id
}


