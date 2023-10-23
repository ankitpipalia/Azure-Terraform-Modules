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
# LOG ANALYTICS WORKSPACE & SOLUTION
#################################################################
resource "azurerm_log_analytics_workspace" "this" {
  name                = "log-aks"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

#################################################################
# KUBERNETES CLUSTER
#################################################################
module "aks_cluster" {
  source = "Retoxx-dev/kubernetes-cluster/azurerm"

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

  oms_agent = {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  }
}