module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location            = "centralindia"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "storage_account" {
  source               = "./modules/Storage/storage-account"
  storage_account_name = "xyzstgabcpqr924"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  account_tier         = "Standard"
  replication_type     = "LRS"

  default_network_rule = "Deny" # Allow or Deny All Public Access Not Recommanded Use Your Public IP using Access List

  access_list = {
    "ip1" = "14.99.102.226" # List Of IP's can access the storage account
  }


  static_website_enabled = true
  index_path             = "index.html"
  custom_404_path        = "error.html"

  containers = [
    {
      name        = "images"
      access_type = "private"
    },
    {
      name        = "thumbnails"
      access_type = "private"
    }
  ]

  tags       = local.tags
  extra_tags = local.extra_tags
}

module "law" {
  source = "./modules/Moniter/log-analytics-workspace"

  log_analytics_workspace_name = "test-law"
  resource_group_name          = module.resource_group.name
  location                     = module.resource_group.location
  sku                          = "PerGB2018"
  retention_in_days            = 30
  tags                         = local.tags
  extra_tags                   = local.extra_tags

  depends_on = [module.resource_group, module.storage_account]
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "example" {
  name                       = "ankitsdfkjhfkvdv"
  location                   = module.resource_group.location
  resource_group_name        = module.resource_group.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  sku_name                   = "standard"
}