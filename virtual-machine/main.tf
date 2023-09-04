locals {
  count = random_integer.count.result

  virtual_machine_name = "${var.tags.environment}-${var.tags.project}-vm-${local.count}"
  nic_name             = "${var.tags.environment}-${var.tags.project}-nic-${local.count}"
  public_ip_name       = "${var.tags.environment}-${var.tags.project}-public-ip-${local.count}"
}

resource "random_integer" "count" {
  min = 01
  max = 99
}

resource "azurerm_virtual_machine" "vm" {
  vm_name               = local.virtual_machine_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_os_disk {
    name              = var.os_disk_name
    caching           = var.os_disk_caching
    create_option     = var.os_disk_create_option
    managed_disk_type = var.os_disk_managed_disk_type
    disk_size_gb      = var.os_disk_size_gb
  }

  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = var.disable_password_authentication
    ssh_keys {
      path     = var.ssh_key_path
      key_data = var.ssh_key_data
    }
  }

  boot_diagnostics {
    enabled     = var.boot_diagnostics_enabled
    storage_uri = var.boot_diagnostics_storage_uri
  }

  tags = var.tags
}

resource "azurerm_public_ip" "primary" {
  name                = local.public_ip_name
  location            = var.names.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  allocation_method = var.public_ip_allocation
  sku               = var.public_ip_sku
}

resource "azurerm_network_interface" "dynamic" {
  name                = local.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                          = var.tags
  enable_accelerated_networking = var.accelerated_networking

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address            = var.private_ip_address
    public_ip_address_id          = azurerm_public_ip.primary[0].id
  }
}
