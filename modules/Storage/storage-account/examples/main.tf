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
  storage_account_name = "ankitstgsimform924"
  #storage_account_name_validation = length(local.storage_account_name) >= 3 && length(local.storage_account_name) <= 24 && can(regex("^[a-z0-9]*$", local.storage_account_name))
}

module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location = "centralindia"
  tags = local.tags
  extra_tags = local.extra_tags
}

module "storage_acount" {
  source = "./modules/Storage/storage-account"
  #storage_account_name = local.storage_account_name_validation ? local.storage_account_name : assert(false, "Invalid storage account name. The name can only consist of lowercase letters and numbers, and must be between 3 and 24 characters long.")
  storage_account_name = local.storage_account_name
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  account_tier = "Standard"
  replication_type = "LRS"

  default_network_rule = "Deny" # Allow or Deny All Public Access Not Recommanded Use Your Public IP using Access List

  access_list = {
    "ip1" = "xx.xx.xx.xx" # List Of IP's can access the storage account
  }


  static_website_enabled = true
  index_path = "index.html"
  custom_404_path = "error.html"

  containers = [
    {
      name = "images"
      access_type = "private"
    },
    {
      name = "thumbnails"
      access_type = "private"
    }
  ]
  
  tags = local.tags
  extra_tags = local.extra_tags
}