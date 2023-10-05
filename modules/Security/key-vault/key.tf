resource "azurerm_key_vault" "key-vault" {
  name                            = var.key_vault_name
  resource_group_name             = var.resource_group_name
  sku_name                        = var.sku_name
  location                        = var.location
  enable_rbac_authorization       = var.enable_rbac_authorization
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  purge_protection_enabled        = var.purge_protection_enabled
  tenant_id                       = var.tenant_id
  public_network_access_enabled   = var.public_network_access_enabled

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )

  dynamic "contact" {
    for_each = var.contacts
    content {
      name  = contact.value.name
      email = contact.value.email
      phone = contact.value.phone
    }
  }

  # Only one network_acls block is allowed.
  # Create it if the variable is not null.
  dynamic "network_acls" {
    for_each = var.network_acls != null ? { this = var.network_acls } : {}
    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids
    }
  }
}