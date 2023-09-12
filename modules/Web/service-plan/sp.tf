resource "azurerm_service_plan" "asp" {

  name                     = var.name
  location                 = var.location
  os_type                  = var.os_type
  resource_group_name      = var.resource_group_name
  sku_name                 = var.sku_name

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )

  per_site_scaling_enabled = var.per_site_scaling_enabled
  worker_count             = var.worker_count
}