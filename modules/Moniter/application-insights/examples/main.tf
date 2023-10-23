module "application_insight" {
  source = "./modules/application-insights"

  application_insights_name = "test-app-insights"
  location                  = module.resource_group.location
  resource_group_name       = module.resource_group.name
  workspace_id              = module.law.id
  application_type          = "web"

  tags       = local.tags
  extra_tags = local.extra_tags

  depends_on = [module.resource_group, module.law]
}