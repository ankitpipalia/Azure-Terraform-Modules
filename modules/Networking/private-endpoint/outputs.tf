output "private_endpoint_id" {
  description = "The ID of the private endpoint."
  value       = azurerm_private_endpoint.example.id
}

output "private_endpoint_name" {
  description = "The name of the private endpoint."
  value       = azurerm_private_endpoint.example.name
}

output "dns_zone_group_name" {
  value = azurerm_private_endpoint.example.private_dns_zone_group[0].name
}

output "dns_zone_ids" {
  value = azurerm_private_endpoint.example.private_dns_zone_group[0].private_dns_zone_ids
}