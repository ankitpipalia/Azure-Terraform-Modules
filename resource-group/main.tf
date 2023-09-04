locals {
  resource_group_name = "${var.tags.environment}_${var.tags.project}-rg"
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
}