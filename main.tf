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
  subscription_id = ""
}

module "vnet" { 
  source = "./virtual-network"
  names = {
    "project_name" = "aks"
    "resource_group_type" = "test"
  }
  location = "centralindia"
  resource_group_name = "test"
  address_space = [ "10.0.0.0/16" ]
  tags = {
    environment = "test"
  }
  subnets = {
    subnet1 = {
      subnet_type = "aks1"
      cidrs = [ "10.0.1.0/24" ]
    }
    subnet2 = {
      subnet_type = "aks2"
      cidrs = [ "10.0.2.0/24" ]
    }
  }
}



