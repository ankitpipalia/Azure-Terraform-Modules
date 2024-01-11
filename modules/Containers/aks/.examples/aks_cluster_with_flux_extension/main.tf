#################################################################
# PROVIDER STUFF
#################################################################
terraform {
  required_version = ">= 1.3.1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.65"
    }
  }
}

provider "azurerm" {
  features {}
}

#################################################################
# RESOURCE GROUP
#################################################################
resource "azurerm_resource_group" "this" {
  name     = "rg-aks"
  location = "northeurope"

  tags = {
    "Environment" = "Dev"
  }
}

#################################################################
# VIRTUAL NETWORK
#################################################################
module "vnet" {
  source  = "Retoxx-dev/virtual-network/azurerm"
  version = "1.0.1"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  name          = "vnet-aks"
  address_space = ["10.0.0.0/16"]
  subnets = [
    {
      name             = "snet-aks-app"
      address_prefixes = ["10.0.224.0/20"]
    }
  ]
}

#################################################################
# KUBERNETES CLUSTER
#################################################################
module "aks_cluster" {
  #source = "Retoxx-dev/kubernetes-cluster/azurerm"
  source = "../../"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  name               = "aks"
  kubernetes_version = "1.26.3"
  dns_prefix         = "aks"

  network_profile = {
    network_plugin = "azure"
    dns_service_ip = "10.2.0.10"
    outbound_type  = "loadBalancer"
    service_cidr   = "10.2.0.0/24"
  }

  default_node_pool = {
    name                   = "default"
    vm_size                = "standard_b2s"
    vnet_subnet_id         = module.vnet.subnet_ids["snet-aks-app"]
    zones                  = ["1"]
    min_count              = 2
    max_count              = 3
    enable_host_encryption = false
    enable_node_public_ip  = false
    max_pods               = 45
    orchestrator_version   = "1.26.3"
  }

  identity = {
    name = "aks"
  }

  cluster_extentions = [
    {
      name           = "flux",
      extension_type = "microsoft.flux"
    }
  ]
}

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

  identity = {
    type = "UserAssigned"
  }

  cluster_extentions = [
    {
      name           = "flux",
      extension_type = "microsoft.flux"
    }
  ]

  tags       = local.tags
  extra_tags = local.extra_tags
}