module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "testrg-HQ"
  location            = "eastus2"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "virtual_network" {
  source = "./modules/Networking/virtual-network"

  virtual_network_name = "aks-vnet"
  location             = module.resource_group.location
  resource_group_name  = module.resource_group.name
  address_space        = ["10.0.0.0/12"]
  tags                 = local.tags
  extra_tags           = local.extra_tags

  depends_on = [module.resource_group]
}

module "subnet" {
  source   = "./modules/Networking/subnets"
  for_each = { for subnet in flatten(local.subnets) : subnet.subnet_name => subnet }

  subnet_name           = each.value.subnet_name
  resource_group_name   = module.resource_group.name
  virtual_network_name  = module.virtual_network.name
  subnet_address_prefix = each.value.subnet_address_prefix
  depends_on            = [module.virtual_network]
}

module "law" {
  source = "./modules/Moniter/log-analytics-workspace"

  log_analytics_workspace_name = "aks-law"
  resource_group_name          = module.resource_group.name
  location                     = module.resource_group.location
  sku                          = "PerGB2018"
  retention_in_days            = 30

  tags       = local.tags
  extra_tags = local.extra_tags

  depends_on = [module.resource_group]
}

module "application_insight" {
  source = "./modules/Moniter/application-insights"

  application_insights_name = "test-app-insights"
  location                  = module.resource_group.location
  resource_group_name       = module.resource_group.name
  workspace_id              = module.law.id
  application_type          = "web"

  tags       = local.tags
  extra_tags = local.extra_tags

  depends_on = [module.resource_group, module.law]
}

module "apim" {
  source = "./modules/Web/api-management"

  apim_name           = "sbhfdhj-123"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  sku_name        = "Developer_1"
  publisher_name  = "Ankit Pipalia"
  publisher_email = "ankit.pipalia009@outlook.com"

  virtual_network_type = "External"

  apim_settings = {
    virtual_network_configuration = {
      subnet_id = module.subnet["test-apim"].id
    }
  }

  tags       = local.tags
  extra_tags = local.extra_tags

  depends_on = [module.resource_group, module.subnet["test-apim"]]
}

resource "azurerm_api_management_logger" "example" {
  name                = "example-logger"
  api_management_name = module.apim.name
  resource_group_name = module.resource_group.name
  resource_id         = module.application_insight.id

  application_insights {
    instrumentation_key = module.application_insight.instrumentation_key
  }

  depends_on = [module.apim, module.application_insight]
}