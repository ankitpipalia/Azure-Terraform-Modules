output "dns_zone_id" {
  value = azurerm_private_dns_zone.private_dns_zone.id
}

output "virtual_network_link_id" {
  description = "Virtal Network Link Id"
  value       = [for vlink in azurerm_private_dns_zone_virtual_network_link.virtual_network_link : vlink.id]
}