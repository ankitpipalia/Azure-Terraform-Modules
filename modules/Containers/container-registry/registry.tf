resource "azurerm_container_registry" "acr" {

  resource_group_name           = var.resource_group_name
  name                          = var.registry_name
  location                      = var.location
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.allow_public_access
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  anonymous_pull_enabled        = var.allow_anonymous_pull_enabled
  network_rule_bypass_option    = var.network_rule_bypass_option

  tags = merge({
    "Environment" = var.tags.environment
    "Project"     = var.tags.project
  }, var.extra_tags)


  dynamic "georeplications" {
    for_each = var.georeplications ? var.georeplications : []

    content {
      location                  = georeplications.location
      regional_endpoint_enabled = georeplications.regional_endpoint_enabled
      zone_redundancy_enabled   = georeplications.zone_redundancy_enabled
      tags                      = georeplications.tags
    }
  }

  dynamic "network_rule_set" {
    for_each = var.network_rule_set != null ? [var.network_rule_sets] : []

    content {
      default_action = network_rule_set.default_action

      dynamic "ip_rule" {
        for_each = network_rule_set.value.ip_rule

        content {
          action   = "Allow"
          ip_range = ip_rule.ip_range
        }
      }

      dynamic "virtual_network" {
        for_each = network_rule_set.value.virtual_network
        content {
          action    = "Allow"
          subent_id = virtual_network.value.subent_id
        }
      }
    }


    identity {
      type         = var.identity_ids != null ? "SystemAssigned, UserAssigned" : "SystemAssigned"
      identity_ids = var.identity_ids
    }


    dynamic "encryption" {
      for_each = var.encryption != null ? [var.encryption] : []
      content {
        enabled            = true
        key_vault_key_id   = encryption.value.key_vault_key_id
        identity_client_id = encryption.value.identity_client_id
      }
    }
  }

  resource "azurerm_monitor_diagnostic_setting" "acr-diag" {
    count                      = var.log_analytics_workspace_name != null ? 1 : 0
    name                       = lower("acr-${var.container_registry_config.name}-diag")
    target_resource_id         = azurerm_container_registry.acr.id
    storage_account_id         = var.storage_account_name != null ? data.azurerm_storage_account.storeacc.0.id : null
    log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logws.0.id

    dynamic "log" {
      for_each = var.acr_diag_logs
      content {
        category = log.value
        enabled  = true

        retention_policy {
          enabled = false
          days    = 0
        }
      }
    }

    metric {
      category = "AllMetrics"

      retention_policy {
        enabled = false
        days    = 0
      }
    }

    lifecycle {
      ignore_changes = [log, metric]
    }
  }

}








