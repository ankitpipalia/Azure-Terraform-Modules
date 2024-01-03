module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location            = "centralindia"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "key-vault" {
  source = "./modules/Security/key-vault"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  sku_name                 = "standard"
  purge_protection_enabled = false

  create_access_policy    = true
  key_permissions         = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
  secret_permissions      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
  certificate_permissions = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]

  environment = local.env_vars.locals.environment
  project     = local.project_vars.locals.project

  network_acls = {
    bypass         = "AzureServices"
    default_action = "Allow"
  }

  tags       = local.tags
  extra_tags = local.extra_tags
}
