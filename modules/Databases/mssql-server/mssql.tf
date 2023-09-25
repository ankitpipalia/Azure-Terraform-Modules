resource "azurerm_mssql_server" "mssql_server" {
  name                          = var.mssql_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.server_version
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_login_password
  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = var.public_network_access_enabled
  connection_policy             = var.connection_policy

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
      administrator_login_password,
    ]
  }

  identity {
    type = "SystemAssigned"
  }

  azuread_administrator {
    login_username = var.azure_ad_admin_login
    object_id      = var.azure_ad_admin_object_id
  }
}

resource "azurerm_key_vault_access_policy" "tde_policy" {
  count = var.tde_encryption_enabled ? 1 : 0

  key_vault_id    = var.key_vault_id
  tenant_id       = azurerm_mssql_server.mssql_server.identity[0].tenant_id
  object_id       = azurerm_mssql_server.mssql_server.identity[0].principal_id
  key_permissions = var.tde_key_permissions
}

resource "azurerm_mssql_server_transparent_data_encryption" "mssql_server" {
  count = var.tde_encryption_enabled ? 1 : 0

  server_id             = azurerm_mssql_server.mssql_server.id
  key_vault_key_id      = var.key_vault_key_id
  auto_rotation_enabled = var.auto_rotation_enabled

  depends_on = [azurerm_key_vault_access_policy.tde_policy]
}

resource "azurerm_mssql_firewall_rule" "azure_services" {
  count = var.firewall_rule_name == null ? 0 : 1

  name             = var.firewall_rule_name
  server_id        = azurerm_mssql_server.mssql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_server_security_alert_policy" "mssql_server" {
  count = var.mssql_defender_state == null ? 0 : 1

  resource_group_name = azurerm_mssql_server.mssql_server.resource_group_name
  server_name         = azurerm_mssql_server.mssql_server.name
  state               = var.mssql_defender_state
}