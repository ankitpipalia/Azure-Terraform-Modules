resource "azurerm_virtual_network" "vnet" {
  name                = coalesce(var.virtual_network_name, "${var.project}-${var.environment}-vnet")
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )
}