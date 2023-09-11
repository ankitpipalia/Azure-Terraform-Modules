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
  custom_tags = {
    owner = "user1"
  }
}

module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location = "centralindia"
  tags = local.tags
  custom_tags = local.custom_tags
}

module "service_plan" {
  source = "./modules/Web/service-plan"
  name = "ankit-test-plan"
  location = "eastus"
  os_type = "Linux"
  resource_group_name = module.resource_group.name
  sku_name = "B1"

  tags = local.tags
  custom_tags = local.custom_tags
}

module "linux-web-apps" {
  source = "./modules/Web/linux-web-apps"
  linux_web_app_name = "ankit-test-web-app"
  location = "eastus"
  resource_group = module.resource_group.name
  service_plan_id = module.service_plan.id
  https_only = true
  enabled = true
  tags = local.tags
  custom_tags = local.custom_tags
  
  
  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITES_CONTAINER_START_TIME_LIMIT" = "1800"
    "WEBSITES_PORT" = "8080"
  }


  client_affinity_enabled = false
  identity_ids = "SystemAssigned"


  site_config = {
    always_on = true
    container_registry_managed_identity_client_id = null
    container_registry_use_managed_identity = false
    ftps_state = "Disabled"
    http2_enabled = true
    use_32_bit_worker = false
    websockets_enabled = true
    worker_count = 1
  }

  application_stack = {
    name = "NODE|14-lts"
    version = "14.17"
  }

  logs {
    
  }
}