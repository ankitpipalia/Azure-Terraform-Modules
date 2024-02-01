data "azurerm_client_config" "current" {}

resource "azurerm_postgresql_active_directory_administrator" "aad" {
  count = var.create_key_secret ? 1 : 0

  server_name         = azurerm_postgresql_server.db.name
  resource_group_name = var.resource_group_name
  login               = var.server_administrator_login
  object_id           = var.object_id
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_postgresql_server" "db" {
  name                = var.postgresql_server_name
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.administrator_login
  administrator_login_password = var.use_random_string ? random_password.password[0].result : var.administrator_login_password
  
  sku_name   = var.sku
  version    = var.postgresql_version
  storage_mb = var.max_allocated_storage_mb

  backup_retention_days = var.backup_retention_days
  auto_grow_enabled     = var.auto_grow_enabled

  public_network_access_enabled = var.publicly_accessible

  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  dynamic "threat_detection_policy" {
    for_each = var.threat_detection_policies
    content {
      enabled                    = threat_detection_policy.value.enabled
      disabled_alerts            = threat_detection_policy.value.disabled_alerts
      email_account_admins       = threat_detection_policy.value.email_account_admins
      email_addresses            = threat_detection_policy.value.email_addresses
      retention_days             = threat_detection_policy.value.retention_days
      storage_account_access_key = threat_detection_policy.value.storage_account_access_key
      storage_endpoint           = threat_detection_policy.value.storage_endpoint
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
resource "azurerm_postgresql_configuration" "log_checkpoints" {
  name                = "log_checkpoints"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.db.name
  value               = var.postgresql_value
}

resource "azurerm_postgresql_configuration" "log_connections" {
  name                = "log_connections"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.db.name
  value               = var.postgresql_value
}
resource "azurerm_postgresql_configuration" "example" {
  name                = "connection_throttling"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.db.name
  value               = var.postgresql_value
}

resource "azurerm_postgresql_database" "db" {
  name                = var.postgresql_database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.db.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_virtual_network_rule" "vnet_access" {
  name                                 = var.postgresql_server_name
  resource_group_name                  = var.resource_group_name
  server_name                          = azurerm_postgresql_server.db.name
  subnet_id                            = var.subnet_id
  ignore_missing_vnet_service_endpoint = true
}

resource "azurerm_postgresql_firewall_rule" "custom_rules" {
  for_each = toset(var.additional_ip_allowlist)

  name                = "${var.postgresql_server_name}-${md5(each.value)}"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.db.name
  start_ip_address    = each.value
  end_ip_address      = each.value
}

# resource "azurerm_key_vault_secret" "secret" {
#   count = var.create_key_secret ? 1 : 0

#   name         = "${var.postgresql_server_name}-secret"
#   value        = var.use_random_string ? random_password.password[0].result : var.administrator_login_password
#   key_vault_id = var.key_vault_id

#   depends_on = [ azurerm_postgresql_database.db ]
# }

resource "random_password" "password" {
  count = var.use_random_string ? 1 : 0

  length  = 16
  special = false
}
