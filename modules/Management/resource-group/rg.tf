resource "azurerm_resource_group" "rg" {
  name     = coalesce(var.resource_group_name, "${var.tags.project}-${var.tags.environment}-rg")
  location = var.location
  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )
}