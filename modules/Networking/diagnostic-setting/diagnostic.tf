resource "azurerm_monitor_diagnostic_setting" "diagsetting" {
  name               = var.diagnostic_setting_name
  target_resource_id = var.target_resource_id

  storage_account_id         = var.storage_account_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log_analytics_destination_type = var.log_analytics_destination_type

  dynamic "log" {
    for_each = var.enabled_log

    content {
      category = log.value["category"]
    }
  }

  dynamic "metric" {
    for_each = var.metrics

    content {
      category = metric.value["category"]
    }
  }
}