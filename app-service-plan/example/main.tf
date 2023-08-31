terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.71.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
    
  }
}

module "Resource_Group" {
    source = "../../resource-group"
    names = {
        environment = "dev"
        location = "east"
        project_name = "test"
          
    }
    unique_name = "false"
    location = "East Us"
    tags = {
      environment = "Development"
    }
}

module "App-Service-Plan" {
  source = "../"

  App_Service_Plan_Config = {
  
    "Service-Plan-1" = {
      name                = "Service-Plan-1"
      location            = "East US"
      resource_group_name =  module.Resource_Group.name
      os_type             = "Linux"
      sku                 = "B1"      
    } }
  }

    # "plan2" = {
    #   location            = "West US"
    #   resource_group_name = azurerm_resource_group.example.name
    #   tier                = "Premium"
    #   size                = "P2"
    # },
    # Add more configurations as needed
  





