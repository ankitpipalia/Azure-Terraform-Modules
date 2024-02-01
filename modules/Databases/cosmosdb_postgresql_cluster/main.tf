resource "azurerm_cosmosdb_postgresql_cluster" "postgres" {
  name                                 = var.postgres_name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  administrator_login_password         = var.administrator_login_password
  coordinator_storage_quota_in_mb      = var.coordinator_storage_quota_in_mb
  coordinator_public_ip_access_enabled = var.coordinator_public_ip_access_enabled
  coordinator_vcore_count              = var.coordinator_vcore_count
  node_count                           = var.node_count
  citus_version                        = var.citus_version
  coordinator_server_edition           = var.coordinator_server_edition
  ha_enabled                           = var.ha_enabled
  node_public_ip_access_enabled        = var.node_public_ip_access_enabled
  node_server_edition                  = var.node_server_edition
  node_storage_quota_in_mb             = var.node_storage_quota_in_mb
  point_in_time_in_utc                 = var.point_in_time_in_utc
  preferred_primary_zone               = var.preferred_primary_zone
  shards_on_coordinator_enabled        = var.shards_on_coordinator_enabled
  source_location                      = var.source_location
  source_resource_id                   = var.source_resource_id
  sql_version                          = var.sql_version

  dynamic "maintenance_window" {
    for_each = var.maintenance_window
    content {
      day_of_week  = maintenance_window.value["day_of_week"]
      start_hour   = maintenance_window.value["start_hour"]
      start_minute = maintenance_window.value["start_minute"]
    }

  }
  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )

}
resource "azurerm_cosmosdb_postgresql_coordinator_configuration" "pgsql" {
  name       = var.postgres_coordination_name
  cluster_id = azurerm_cosmosdb_postgresql_cluster.postgres.id
  value      = var.value
}

resource "azurerm_cosmosdb_postgresql_firewall_rule" "example" {
  for_each         = var.firewall_rules
  name             = each.key
  cluster_id       = azurerm_cosmosdb_postgresql_cluster.postgres.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address

  depends_on = [azurerm_cosmosdb_postgresql_cluster.postgres]
}

resource "azurerm_cosmosdb_postgresql_node_configuration" "pgsql1" {
  name       = var.postgres_node_name
  cluster_id = azurerm_cosmosdb_postgresql_cluster.postgres.id
  value      = var.value

  depends_on = [azurerm_cosmosdb_postgresql_cluster.postgres]
}

resource "azurerm_cosmosdb_postgresql_role" "role_name" {
  name       = var.postgres_role_name
  cluster_id = azurerm_cosmosdb_postgresql_cluster.postgres.id
  password   = var.password

  depends_on = [azurerm_cosmosdb_postgresql_cluster.postgres]
}
