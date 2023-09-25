resource "azurerm_firewall" "az_fw" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier
  firewall_policy_id  = var.firewall_policy_id
  dns_servers         = var.dns_servers
  private_ip_ranges   = var.private_ip_ranges
  threat_intel_mode   = var.threat_intel_mode
  zones               = var.zones

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )

  dynamic "virtual_hub" {
    for_each = var.use_virtual_hub ? [] : var.virtual_hub
    content {
      virtual_hub_id  = vvirtual_hub.value.virtual_hub_id
      public_ip_count = virtual_hub.value.public_ip_count
    }
  }
  dynamic "management_ip_configuration" {
    for_each = var.use_management_ip_configuration ? [] : var.management_ip_configuration
    content {
      name                 = management_ip_configuration.value.name
      subnet_id            = management_ip_configuration.value.subnet_id
      public_ip_address_id = management_ip_configuration.value.public_ip_address_id
    }
  }
  dynamic "ip_configuration" {
    for_each = var.use_management_ip_configuration ? [] : var.ip_configuration
    content {
      name                 = ip_configuration.value.name
      subnet_id            = ip_configuration.value.subnet_id
      public_ip_address_id = ip_configuration.value.public_ip_address_id
    }
  }
}
