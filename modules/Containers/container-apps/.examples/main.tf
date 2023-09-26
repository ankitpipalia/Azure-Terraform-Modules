module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location            = "eastus"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "container-apps" {
  source = "./modules/Containers/container-apps"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  container_app_environment_name = "test-container-apps-env"
  tags                = local.tags
  extra_tags          = local.extra_tags

  container_apps = {
    test-container-apps = {
      name = "test-container-apps"
      revision_mode = "Single"

      template = {
        max_replicas    = 1
        min_replicas    = 1
        revision_suffix = "test"

        containers = [
          {
            name   = "test-container"
            image  = "nginx"
            cpu    = 1.0
            memory = "2Gi"
          }
        ]
      }
      ingress = {
        target_port = 80
        allow_insecure_connections = true
        external_enabled = true
        transport = "auto"
        traffic_weight = {
          label = "test"
          latest_revision = "true"
          revision_suffix = "test"
          percentage = 100
        }
      }
    }
  }
}