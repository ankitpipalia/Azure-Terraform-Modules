output "id" {
  description = "The ID of the network interface"
  value       = azurerm_network_interface.nic.id
}

output "private_ip_address" {
  description = "The private IP address of the network interface"
  value       = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
}

output "public_ip_address" {
  description = "The public IP address of the network interface"
  value       = azurerm_network_interface.nic.ip_configuration[0].public_ip_address_id
}