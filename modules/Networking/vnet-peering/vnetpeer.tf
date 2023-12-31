resource "azurerm_virtual_network_peering" "src" {
  name                         = var.src_peering_name
  resource_group_name          = var.src_resource_group_name
  virtual_network_name         = var.src_virtual_network_name
  remote_virtual_network_id    = var.dst_virtual_network_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
  use_remote_gateways          = var.use_remote_gateways
}

resource "azurerm_virtual_network_peering" "dst" {
  name                         = var.dst_peering_name
  resource_group_name          = var.dst_resource_group_name
  virtual_network_name         = var.dst_virtual_network_name
  remote_virtual_network_id    = var.src_virtual_network_id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic
  allow_gateway_transit        = var.allow_gateway_transit
  use_remote_gateways          = var.use_remote_gateways
}