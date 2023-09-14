resource "azurerm_mssql_database" "mssql_database" {
  name                        = var.mssql_database_name
  server_id                   = var.server_id
  collation                   = var.collation
  sku_name                    = var.sku
  max_size_gb                 = var.max_size
  min_capacity                = var.min_capacity
  auto_pause_delay_in_minutes = var.autopause_delay
  create_mode                 = var.create_mode
  creation_source_database_id = var.creation_source_database_id
  storage_account_type        = var.storage_account_type == "ZRS" ? "Zone" : "Geo"
  
  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )

  short_term_retention_policy {
    retention_days = var.retention_days
  }

  lifecycle {
    ignore_changes = [
      sku_name,
    ]
  }
}