module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location            = "centralindia"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

data "azurerm_client_config" "current" {}

module "key-vault" {
  source = "./modules/Security/key-vault"

  key_vault_name      = "hvdhybbfhb645tfh"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  sku_name                 = "standard"
  tenant_id                = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled = false

  tags       = local.tags
  extra_tags = local.extra_tags
}
