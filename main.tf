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

  resource_group_name = "test-rg-1"
  location = "centralindia"
  tags = local.tags
  extra_tags = local.extra_tags
}

module "static_site" {
  source = "./modules/Web/static-web-apps"

  static_site_name = "test-static-site"
  location = "eastasia"
  resource_group = module.resource_group.name
  tags = local.tags
  extra_tags = local.extra_tags
}