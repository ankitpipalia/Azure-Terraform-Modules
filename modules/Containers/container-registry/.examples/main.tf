module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "Example_Resource"
  location            = "eastus"
  tags                = local.tags
  extra_tags          = local.extra_tags
}


module "azurerm_container_registry" {
  source = "./Containers/container-registry"

  registry_name = "example-registry"
  location = "east us"
  resource_gruop_name = "Example_Resource"
}