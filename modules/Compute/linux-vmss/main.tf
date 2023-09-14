resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                            = var.virtual_machine_scale_set_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  sku                             = var.vm_sku
  instances                       = var.instances
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.admin_password == "" ? true : false

  dynamic "admin_ssh_key" {
    for_each = var.admin_password == "" ? ["no_admin_password_provided"] : []
    content {
      username   = var.admin_username
      public_key = var.admin_ssh_public_key
    }
  }

  source_image_id = var.source_image_id

  dynamic "source_image_reference" {
    for_each = var.source_image_id == null ? ["no_custom_image_provided"] : []

    content {
      publisher = var.source_image_publisher
      offer     = var.source_image_offer
      sku       = var.source_image_sku
      version   = var.source_image_version
    }
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  network_interface {
    name    = "${var.virtual_machine_scale_set_name}-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id

      dynamic "public_ip_address" {
        for_each = var.enable_public_ip_address ? [1] : []
        content {
          name = "pip"
        }
      }
      load_balancer_backend_address_pool_ids = var.load_balancer_backend_address_pool_ids
    }
  }

  health_probe_id = var.enable_health_probe_id ? var.health_probe_id : null

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }
}

resource "azurerm_monitor_autoscale_setting" "vmss_as" {
  name                = var.autoscale_setting_name
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = var.enable_vmss_autoscale ? azurerm_linux_virtual_machine_scale_set.vmss.id : null

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
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
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