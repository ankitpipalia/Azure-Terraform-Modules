module "resource_group" {
  source = "./modules/resource-group"

  resource_group_name = "test-rg"
  location            = "centralindia"

  tags = {
    environment = "Production"
    project     = "Project1"
  }
  extra_tags = {
    owner = "user1"
  }
}

module "virtual-network" {
  source = "./modules/virtual-network"

  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  virtual_network_name = "test-vnet"
  address_space = ["172.48.0.0/16"]

  subnets = [
    {
      name           = "Public-subnet"
      address_prefix = "172.48.0.0/24"
    },
    {
      name              = "DB-subnet"
      address_prefix    = "172.48.1.0/24"
      service_endpoints = ["Microsoft.Sql"]
    },
    {
      name           = "Application-subnet"
      address_prefix = "172.48.2.0/24"
      service_endpoints = ["Microsoft.Storage"]
      delegation = {
        name         = "delegation"
        service_name = "Microsoft.Web/serverFarms"
        actions      = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    },
    {
      name           = "vm-subnet"
      address_prefix = "172.48.3.0/24"
    }
  ]

  tags = module.resource_group.rg.tags

}
