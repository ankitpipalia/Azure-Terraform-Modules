resource "azurerm_windows_virtual_machine" "vm" {
  name                  = var.virtual_machine_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [var.network_interface_id]

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
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

  dynamic "boot_diagnostics" {
    for_each = var.enable_boot_diagnostics ? ["enabled"] : []
    content {
      storage_account_uri = var.diagnostics_storage_account_uri
    }
  }

  zone = var.availability_zone

  additional_capabilities {
    ultra_ssd_enabled = var.ultra_ssd_enabled
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )
}