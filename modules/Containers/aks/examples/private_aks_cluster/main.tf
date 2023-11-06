module "resource_group" {
  source = "./modules/resource-group"

  resource_group_name = "testrg-HQ"
  location            = "eastus2"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "virtual_network" {
  source = "./modules/virtual-network"

  virtual_network_name = "aks-vnet"
  location             = module.resource_group.location
  resource_group_name  = module.resource_group.name
  address_space        = ["10.0.0.0/12"]
  tags                 = local.tags
  extra_tags           = local.extra_tags

  depends_on = [module.resource_group]
}

module "subnet" {
  source   = "./modules/subnets"
  for_each = { for subnet in flatten(local.subnets) : subnet.subnet_name => subnet }

  subnet_name           = each.value.subnet_name
  resource_group_name   = module.resource_group.name
  virtual_network_name  = module.virtual_network.name
  subnet_address_prefix = each.value.subnet_address_prefix
  depends_on            = [module.virtual_network]
}

module "law" {
  source = "./modules/log-analytics-workspace"

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

module "aks_cluster" {
  source = "./modules/aks"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  name               = "aks"
  kubernetes_version = "1.26.3"
  dns_prefix         = "aks"

  network_profile = {
    network_plugin = "azure"
    dns_service_ip = "10.2.0.10"
    outbound_type  = "loadBalancer"
    service_cidr   = "10.2.0.0/24"
    network_policy = "azure"
  }

  default_node_pool = {
    name                   = "default"
    vm_size                = "standard_b2s"
    vnet_subnet_id         = module.subnet["test-aks"].id
    zones                  = []
    min_count              = 1
    max_count              = 2
    enable_host_encryption = false
    enable_node_public_ip  = false
    max_pods               = 30
    orchestrator_version   = "1.26.3"
  }

  role_based_access_control_enabled = true

  local_account_disabled = true

  azure_active_directory_role_based_access_control = {
    managed            = true
    azure_rbac_enabled = true
    tenant_id          = "32ec8707-513d-4380-9bc1-2bd02b8b0884"
  }

  automatic_channel_upgrade = "patch"

  private_cluster_enabled = true

  identity = {
    type = "UserAssigned"
  }

  oms_agent = {
    log_analytics_workspace_id = module.law.id
  }

  tags       = local.tags
  extra_tags = local.extra_tags
}