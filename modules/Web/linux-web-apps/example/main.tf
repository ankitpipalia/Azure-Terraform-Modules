terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
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
    environment  = "dev"
    location     = "east"
    project_name = "test"

  }
  unique_name = "false"
  location    = "East Us"
  tags = {
    environment = "Development"
  }
}

module "App-Service-Plan" {
  source = "../../app-service-plan"

  App_Service_Plan_Config = {

    "Service-Plan-1" = {
      name                = "Service-Plan-1"
      location            = "East US"
      resource_group_name = module.Resource_Group.name
      os_type             = "Linux"
      sku                 = "B1"
  } }
}

module "Linux-Web-App" {
  source = "../"

  web_app_name = var.web_app_name

  resource_group_name = module.Resource_Group.name

  location = module.Resource_Group.location

  service_plan_id = module.App-Service-Plan.app_service_ids[0]

  app_settings = {
    Database_URL = "mongo://example.com/"
  }

  https_only = var.enable_https

  tags = var.tags



}

# "plan2" = {
#   location            = "West US"
#   resource_group_name = azurerm_resource_group.example.name
#   tier                = "Premium"
#   size                = "P2"
# },
# Add more configurations as needed






