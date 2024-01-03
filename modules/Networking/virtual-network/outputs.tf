output "name" {
  description = "Virtual Network name"
  value       = azurerm_virtual_network.vnet.name
}

output "id" {
  description = "Virtual Network id"
  value       = azurerm_virtual_network.vnet.id
}

output "location" {
  description = "Virtual Network location"
  value       = azurerm_virtual_network.vnet.location
}

output "rg" {
  description = "Virtual Network resource"
  value       = azurerm_virtual_network.vnet
}

output "address_space" {
  description = "Address space for the virtual network"
  value       = azurerm_virtual_network.vnet.address_space
}

output "subnet_names" {
  description = "Map of subnet names keyed by subnet name"
  value       = { for name, subnet in azurerm_subnet.subnets : name => subnet.name }
}

output "subnet_ids" {
  description = "Map of subnet IDs keyed by subnet name"
  value       = { for name, subnet in azurerm_subnet.subnets : name => subnet.id }
}

output "subnets" {
  description = "Map of all subnet resources keyed by subnet name"
  value       = { for name, subnet in azurerm_subnet.subnets : name => subnet }
}