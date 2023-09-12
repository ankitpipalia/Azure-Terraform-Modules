resource "azurerm_static_site" "static-site" {
  name                = var.static_site_name
  location            = var.location
  resource_group_name = var.resource_group
  sku_tier            = var.sku_tier
  sku_size            = var.sku_size

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )


  dynamic "identity" {
    for_each = var.sku_tier == "Free" ? toset([]) : toset([1])
    content {
      type         = var.identity_ids == null ? "SystemAssigned" : "SystemAssigned, UserAssigned"
      identity_ids = var.identity_ids
    }
  }
}