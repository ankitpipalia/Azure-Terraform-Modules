terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  required_version = "~>1.0"
}


provider "azurerm" {
  features {}
}

locals {
  subnets = ["subnet1", "subnet2", "subnet3"]
  tags = {
    environment = "Production"
    project     = "Project1"
  }
  extra_tags = {
    owner = "user1"
  }
}

module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location            = "centralindia"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "virtual_network" {
  source = "./modules/Networking/virtual-network"

  virtual_network_name = "test-vnet"
  location             = module.resource_group.location
  resource_group_name  = module.resource_group.name
  address_space        = ["10.0.0.0/16"]
  tags                 = local.tags
  extra_tags           = local.extra_tags
}

module "subnets" {
  source = "./modules/Networking/subnets"

  for_each              = toset(local.subnets)
  subnet_name           = each.value
  resource_group_name   = module.resource_group.name
  virtual_network_name  = module.virtual_network.name
  subnet_address_prefix = cidrsubnet(module.virtual_network.address_space[0], 8, index(local.subnets, each.value)) # Ensure unique address for each subnet
  # For example, if you're given a prefix ending in /16 and you want your subnets to have a prefix of /20, then newbits would be 4, because 20 - 16 = 4
}

module "public_ip_address" {
  source = "./modules/Networking/public-ip"

  public_ip_name      = "test-pip"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "nat_gateway" {
  source = "./modules/Networking/nat-gateway"

  nat_gateway_name     = "test-nat-gateway"
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  public_ip_address_id = module.public_ip_address.id
  subnet_id            = module.subnets["subnet1"].id
  tags                 = local.tags
  extra_tags           = local.extra_tags
}
