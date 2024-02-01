module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location            = "centralindia"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "service_plan" {
  source              = "./modules/Web/service-plan"
  name                = "xyz-test-plan"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  os_type             = "Linux"
  sku_name            = "B1"

  tags       = local.tags
  extra_tags = local.extra_tags
}

module "window_function_app" {
  source                      = "./modules/web/window-function-app"
  window_function_name        = "my-window-app"
  location                    = module.resource_group.location
  resource_group_name         = module.resource_group.name
  storage_account_name        = "my-account"
  storage_account_access_key  = "secret_key"
  client_certificate_mode     = "optional"
  service_plan_id             = "your_service_id"
  functions_extension_version = 3
  tags                        = local.tags
  extra_tags                  = local.extra_tags

}
