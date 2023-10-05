resource "azurerm_log_analytics_workspace" "law" {
  name                               = var.log_analytics_workspace_name
  resource_group_name                = var.resource_group_name
  location                           = var.location
  allow_resource_only_permissions    = var.allow_resource_only_permissions
  local_authentication_disabled      = var.local_authentication_disabled
  sku                                = var.sku
  retention_in_days                  = var.retention_in_days
  daily_quota_gb                     = var.daily_quota_gb
  cmk_for_query_forced               = var.cmk_for_query_forced
  internet_ingestion_enabled         = var.internet_ingestion_enabled
  internet_query_enabled             = var.internet_query_enabled
  reservation_capacity_in_gb_per_day = var.reservation_capacity_in_gb_per_day

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )
}