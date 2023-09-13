terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" 
      version = "~>3.0" 
    }
  }
}

provider "azurerm" {
  features {} 
}

locals {
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
  location = "centralindia"
  tags = local.tags
  extra_tags = local.extra_tags
}

module "service_plan" {
  source = "./modules/Web/service-plan"
  name = "xyz-test-plan"
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  os_type = "Linux"
  sku_name = "B1"

  tags = local.tags
  extra_tags = local.extra_tags
}