output "subnet_name" {
  description = "Subnet name"
  value       = azurerm_subnet.subnet.name
}

output "id" {
  description = "Subnet ID"
  value       = azurerm_subnet.subnet.id
}

output "subnet_rg" {
  description = "Subnet resource group"
  value       = azurerm_subnet.subnet.resource_group_name
}

output "subnet" {
  description = "Subnet resource"
  value       = azurerm_subnet.subnet
}