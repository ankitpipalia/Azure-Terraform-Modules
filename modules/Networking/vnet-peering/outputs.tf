output "src_peering_name_to_id_map" {
  value       = { (azurerm_virtual_network_peering.src.name) = azurerm_virtual_network_peering.src.id }
  description = "Map of SRC peering name to ID"
}

output "dst_peering_name_to_id_map" {
  value       = { (azurerm_virtual_network_peering.dst.name) = azurerm_virtual_network_peering.dst.id }
  description = "Map of DST peering name to ID"
}