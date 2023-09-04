terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" 
      version = ">3" 
    }
  }
}

provider "azurerm" {
  features {} 
}

locals {
  subnets = ["subnet1", "subnet2", "subnet3"]
}

module "resource_group" {
  source = "./resource-group"
  tags = {
    environment = "dev" 
    project     = "test" 
  }
  unique_name = "true" 
  location = "centralindia"
}

module "virtual_network" {
  source = "./virtual-network"
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags = {
    environment = "dev" 
    project     = "test" 
  }
  address_space = ["10.0.0.0/16"]
}

module "subnets" {
  source = "./subnets"
  for_each = toset(local.subnets)
  subnet_name = each.value
  resource_group_name = module.resource_group.name
  virtual_network_name = module.virtual_network.name
  subnet_address_prefix = cidrsubnet(module.virtual_network.address_space[0], 8, index(local.subnets, each.value))  # Ensure unique address for each subnet
  # For example, if you're given a prefix ending in /16 and you want your subnets to have a prefix of /20, then newbits would be 4, because 20 - 16 = 4
}

module "virtual_machine" {
  source = "./virtual-machine"
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags = {
    environment = "dev" 
    project     = "test" 
  }
  subnet_id = module.subnets["subnet1"].id
  vm_size = "Standard_DS1_v2"
  admin_username = "azureuser"
  admin_password = "Password1234!"
  disable_password_authentication = false
  ssh_key_path = "~/.ssh/id_rsa.pub"
}