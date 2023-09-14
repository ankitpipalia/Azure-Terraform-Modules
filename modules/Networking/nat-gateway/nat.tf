resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = var.nat_gateway_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = var.nat_sku
  idle_timeout_in_minutes = var.nat_idle_time
  zones                   = var.nat_zones

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gateway" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = var.public_ip_address_id
}

resource "azurerm_subnet_nat_gateway_association" "nat_gateway" {

  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
  subnet_id      = var.subnet_id
}
