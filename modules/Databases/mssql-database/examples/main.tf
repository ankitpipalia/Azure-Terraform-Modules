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
  subnets = ["subnet1", "subnet2", "subnet3"]
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

  resource_group_name = "test-rg"
  location            = "centralindia"
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
}

module "private_dns_zone" {
  source = "./modules/Networking/private-dns-zone"

  private_dns_zone_name = "testdnszone.local"
  resource_group_name   = module.resource_group.name
  tags                  = local.tags
  extra_tags            = local.extra_tags

  depends_on = [module.virtual_network]

  virtual_network_link = {
    testvnetlink = {
      name                 = "testvnetlink"
      virtual_network_id   = module.virtual_network.id
      registration_enabled = true
    }
  }
}

module "mssql_server" {
  source = "./modules/Databases/mssql-server"
  mssql_server_name = "test-mssql-server-xyz"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  administrator_login          = "mssqladmin"
  administrator_login_password = "H@Sh1CoR3!"

  tags                  = local.tags
  extra_tags            = local.extra_tags

  azure_ad_admin_login    = "xyz@outlook.com"
  azure_ad_admin_object_id = "xxxx-xxxx-xxxx-xxxx-xxxx"

}

module "mssql_database" {
  source = "./modules/Databases/mssql-database"
  mssql_database_name = "test-mssql-database-xyz"
  collation = "SQL_Latin1_General_CP1_CI_AS"
  
  
  server_id           = module.mssql_server.id
  storage_account_type = "ZRS"
  server_fqdn = "module.mssql_server.fqdn"

  databases = {
    testdb1 = {
      name = "testdb1"
      collation = "SQL_Latin1_General_CP1_CI_AS"
    }
  }

  sku = "GP_S_Gen5_2"
  max_size = "20"
  min_capacity = "0.5"

  tags       = local.tags
  extra_tags = local.extra_tags
}