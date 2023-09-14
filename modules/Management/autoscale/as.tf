resource "azurerm_monitor_autoscale_setting" "vmss_as" {
  name                = var.autoscale_setting_name
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = var.target_resource_id

  profile {
    name = var.profile_name

    capacity {
      default = var.default_capacity
      minimum = var.minimum_capacity
      maximum = var.maximum_capacity
    }

    rule {
      metric_trigger {
        metric_name        = var.metric_name
        metric_namespace   = var.metric_namespace
        metric_resource_id = var.metric_resource_id
        time_grain         = var.time_grain
        statistic          = var.statistic
        time_window        = var.time_window
        time_aggregation   = var.time_aggregation
        operator           = var.operator
        threshold          = var.threshold
      }

      scale_action {
        direction = var.scale_direction
        type      = var.scale_type
        value     = var.scale_value
        cooldown  = var.scale_cooldown
      }
    }
  }
}