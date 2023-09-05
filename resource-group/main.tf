locals {
  count = random_integer.count.result
  resource_group_name = "${var.tags.environment}_${var.tags.project}-rg-${local.count}"
}

resource "random_integer" "count" {
  min = 01
  max = 99
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
}