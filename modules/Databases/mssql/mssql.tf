resource "azurerm_mssql_server" "mssql_server" {
  name                                         = var.mssql_server_name
  resource_group_name                          = var.resource_group_name
  location                                     = var.location
  version                                      = var.server_version
  administrator_login                          = var.administrator_login
  administrator_login_password                 = var.administrator_login_password
  minimum_tls_version                          = var.minimum_tls_version
  public_network_access_enabled                = var.public_network_access_enabled
  connection_policy                            = var.connection_policy
  transparent_data_encryption_key_vault_key_id = var.transparent_data_encryption_key_vault_key_id
  outbound_network_restriction_enabled         = var.outbound_network_restriction_enabled
  primary_user_assigned_identity_id            = var.primary_user_assigned_identity_id

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
    type         = "SystemAssigned"
    identity_ids = var.identity_ids
  }

  azuread_administrator {
    login_username              = var.azure_ad_admin_login
    object_id                   = var.azure_ad_admin_object_id
    tenant_id                   = var.tenant_id
    azuread_authentication_only = var.azuread_authentication_only
  }
}

resource "azurerm_mssql_server_extended_auditing_policy" "mssql_server" {
  server_id                               = azurerm_mssql_server.mssql_server.id
  storage_endpoint                        = var.extended_auditing_storage_endpoint
  storage_account_access_key              = var.extended_auditing_storage_account_access_key
  storage_account_access_key_is_secondary = var.storage_account_access_key_is_secondary
}

resource "azurerm_key_vault_access_policy" "tde_policy" {
  count = var.tde_encryption_enabled ? 1 : 0

  key_vault_id    = var.key_vault_id
  tenant_id       = azurerm_mssql_server.mssql_server.identity[0].tenant_id
  object_id       = azurerm_mssql_server.mssql_server.identity[0].principal_id
  key_permissions = var.tde_key_permissions
}

resource "azurerm_mssql_database" "mssql_database" {
  name                        = var.mssql_database_name
  server_id                   = azurerm_mssql_server.mssql_server.id
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
