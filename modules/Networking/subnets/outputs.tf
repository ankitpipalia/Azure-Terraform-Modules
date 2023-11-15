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
