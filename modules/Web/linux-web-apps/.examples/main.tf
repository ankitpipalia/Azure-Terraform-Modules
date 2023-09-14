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

module "linux-web-apps" {
  source              = "./modules/Web/linux-web-apps"
  name                = "xyz-test-app"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  service_plan_id     = module.service_plan.id

  tags       = local.tags
  extra_tags = local.extra_tags

  identity_type = "SystemAssigned"

  settings = {
    site_config = {
      minimum_tls_version = "1.2"
      http2_enabled       = true

      application_stack = {
        node_version = "18-lts"
      }
    }

    auth_settings = {
      enabled                       = false
      runtime_version               = "~1"
      unauthenticated_client_action = "AllowAnonymous"
    }
  }
}