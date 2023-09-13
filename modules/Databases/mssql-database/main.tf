resource "azurerm_mssql_database" "this" {
  name                        = var.mssql_database_name
  server_id                   = var.server_id
  collation                   = lookup(each.value, "collation", var.default_collation)
  sku_name                    = lookup(each.value, "sku", var.default_sku)
  max_size_gb                 = lookup(each.value, "max_size", var.default_max_size)
  min_capacity                = lookup(each.value, "min_capacity", var.default_min_capacity)
  auto_pause_delay_in_minutes = lookup(each.value, "auto_pause_delay", var.default_autopause_delay)
  create_mode                 = lookup(each.value, "create_mode", var.default_create_mode)
  creation_source_database_id = lookup(each.value, "creation_source_database_id", var.default_creation_source_database_id)
  storage_account_type        = var.storage_account_type == "ZRS" ? "Zone" : "Geo"
  tags                        = var.tags

  short_term_retention_policy {
    retention_days = lookup(each.value, "retention_days", var.default_retention_days)
  }

  lifecycle {
    ignore_changes = [
      sku_name,
    ]
  }
}