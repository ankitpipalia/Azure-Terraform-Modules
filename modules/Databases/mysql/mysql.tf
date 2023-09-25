resource "azurerm_mysql_flexible_server" "mysql" {
  resource_group_name          = var.resource_group_name
  location                     = var.location
  name                         = var.mysql_server_name
  administrator_login          = var.administrator_login
  administrator_password       = var.administrator_password
  backup_retention_days        = var.backup_retention_days
  create_mode                  = var.create_mode
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  sku_name                     = var.server_sku_name
  version                      = var.mysql_version
  zone                         = var.zone

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )

  lifecycle {
    ignore_changes = [
      administrator_login,
      administrator_password,
    ]
  }

}

resource "azurerm_mysql_flexible_database" "database" {
  name     = var.database_name
  resource_group_name = azurerm_mysql_flexible_server.mysql.resource_group_name
  server_name = azurerm_mysql_flexible_server.mysql.name
  charset  = var.charset
  collation = var.collation

  depends_on = [ azurerm_mysql_flexible_server.mysql ]
}

resource "azurerm_mysql_flexible_server_firewall_rule" "firewall_rule" {
  name                = "${var.mysql_server_name}-firewallrule"
  resource_group_name = var.resource_group_name
  server_name         = var.mysql_server_name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"

  depends_on = [azurerm_mysql_flexible_server.mysql]
}

resource "azurerm_key_vault_secret" "mysql_password" {
  count = var.store_db_password_in_keyvault ? 1 : 0

  name         = "${var.mysql_server_name}-pwd"
  value        = var.administrator_password
  key_vault_id = var.key_vault_id

  depends_on = [azurerm_mysql_flexible_server.mysql]
}