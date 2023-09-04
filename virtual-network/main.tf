locals {
  virtual_network_name = "${var.tags.environment}-${var.tags.project}-vnet"
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.virtual_network_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags
}