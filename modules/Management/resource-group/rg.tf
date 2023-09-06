resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.custom_tags
  )
}