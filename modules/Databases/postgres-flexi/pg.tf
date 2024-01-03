resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  resource_group_name = var.resource_group_name
  name                = var.postgresql_flexible_server_name
  location            = var.location

  sku_name   = var.sku_name
  storage_mb = var.storage_mb
  version    = var.postgresql_version

  zone = var.zone

  dynamic "high_availability" {
    for_each = var.standby_zone != null && var.tier != "Burstable" ? toset([var.standby_zone]) : toset([])

    content {
      mode                      = "ZoneRedundant"
      standby_availability_zone = high_availability.value
    }
  }

  administrator_login    = var.administrator_login
  administrator_password = var.use_random_string ? random_password.password[0].result : var.administrator_password

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? toset([var.maintenance_window]) : toset([])

    content {
      day_of_week  = lookup(maintenance_window.value, "day_of_week", 0)
      start_hour   = lookup(maintenance_window.value, "start_hour", 0)
      start_minute = lookup(maintenance_window.value, "start_minute", 0)
    }
  }

  private_dns_zone_id = var.private_dns_zone_id
  delegated_subnet_id = var.delegated_subnet_id

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )

  lifecycle {
    precondition {
      condition     = var.private_dns_zone_id != null && var.delegated_subnet_id != null || var.private_dns_zone_id == null && var.delegated_subnet_id == null
      error_message = "var.private_dns_zone_id and var.delegated_subnet_id should either both be set or none of them."
    }
  }
}

resource "azurerm_postgresql_flexible_server_database" "postgresql_flexible_db" {
  for_each = var.databases

  name      = each.key
  server_id = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
  charset   = each.value.charset
  collation = each.value.collation

}

resource "azurerm_postgresql_flexible_server_configuration" "postgresql_flexible_config" {
  for_each  = var.postgresql_configurations
  name      = each.key
  server_id = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
  value     = each.value
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "firewall_rules" {
  for_each = var.allowed_cidrs

  name             = each.key
  server_id        = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
  start_ip_address = cidrhost(each.value, 0)
  end_ip_address   = cidrhost(each.value, -1)
}

resource "random_password" "password" {
  count = var.use_random_string ? 1 : 0

  length  = 12
  special = false
  min_upper        = 4
  min_lower        = 5
  min_numeric      = 3
}

resource "azurerm_key_vault_secret" "secret" {
  for_each = var.create_key_secret

  name         = each.key
  value        = var.use_random_string ? random_password.password[0].result : var.administrator_password
  key_vault_id = each.value.key_vault_id

  content_type = each.value.content_type

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )

  expiration_date = each.value.expiration_date
  not_before_date = each.value.not_before_date
}