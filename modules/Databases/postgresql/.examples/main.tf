module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location            = "eastus"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "virtual_network" {
  source = "./modules/Networking/virtual-network"

  virtual_network_name = "test-vnet"
  location             = module.resource_group.location
  resource_group_name  = module.resource_group.name
  address_space        = ["10.0.0.0/16"]
  tags                 = local.tags
  extra_tags           = local.extra_tags
}

module "subnets" {
  source = "./modules/Networking/subnets"

  for_each              = toset(local.subnets)
  subnet_name           = each.value
  resource_group_name   = module.resource_group.name
  virtual_network_name  = module.virtual_network.name
  subnet_address_prefix = cidrsubnet(module.virtual_network.address_space[0], 8, index(local.subnets, each.value)) # Ensure unique address for each subnet
  # For example, if you're given a prefix ending in /16 and you want your subnets to have a prefix of /20, then newbits would be 4, because 20 - 16 = 4

  service_endpoints = "Microsoft.Sql"
}

module "pg_db" {
  source = "./modules/Databases/postgresql"

  location             = module.resource_group.location
  resource_group_name  = module.resource_group.name

  postgresql_server_name = "tesadasdst-pg"
  sku                    = "GP_Gen5_2" # Changed SKU to support vnet access
  subnet_id = module.subnets["subnet1"].id
  postgresql_database_name     = "testxyabzcpg-db"
  administrator_login          = "pgsqladmin"
  administrator_login_password = "P@ssw0rd1234"

  tags                = local.tags
  extra_tags          = local.extra_tags
}