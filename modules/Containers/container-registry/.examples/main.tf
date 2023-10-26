module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "Example_Resource"
  location            = "eastus"
  tags                = local.tags
  extra_tags          = local.extra_tags
}


module "azurerm_container_registry" {
  source = "./modules/Containers/container-registry"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  container_registry_config = {
    name                          = "xyzabctestregistry"
    admin_enabled                 = true
    sku                           = "Premium"
    public_network_access_enabled = true
    quarantine_policy_enabled     = true
    zone_redundancy_enabled       = true
  }

  tags       = local.tags
  extra_tags = local.extra_tags

}