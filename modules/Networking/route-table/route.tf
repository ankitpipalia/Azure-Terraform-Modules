resource "azurerm_route_table" "rt" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dynamic "route" {
    for_each = var.routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = lookup(route.value, "next_hop_in_ip_address", null)
    }
  }
  disable_bgp_route_propagation = var.disable_bgp_route_propagation

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )
}

resource "azurerm_subnet_route_table_association" "rtsa" {
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.rt.id
}