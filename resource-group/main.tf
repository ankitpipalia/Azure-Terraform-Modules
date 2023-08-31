locals {
  resource_group_name = "${var.names.project_name}_${var.location}_${var.names.environment}"

  unique_name = var.unique_name == "true" ? random_integer.suffix[0].result : (var.unique_name == "false" ? null : var.unique_name)
}

resource "random_integer" "suffix" {
  count = var.unique_name == "true" ? 1 : 0

  min = 10000
  max = 99999
}

resource "azurerm_resource_group" "rg" {
  # name     = local.unique_name != null ? "${local.resource_group_name}-${local.unique_name}" : local.resource_group_name
  name     = "${var.names.project_name}-${var.names.location}-${var.names.environment}"
  location = var.location
  tags     = var.tags
}