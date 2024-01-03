module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location            = "eastus"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "pg_db" {
  source = "./modules/Databases/postgres-flexi"

  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  postgresql_flexible_server_name = "tesadasdst-pg"
  sku_name                        = "B_Standard_B1ms"
  storage_mb                      = 32768

  databases = {
    testdb = {
      charset   = "UTF8"
      collation = "en_US.utf8"
    }
  }

  administrator_login    = "pgsqladmin"
  administrator_password = "P@ssw0rd1234"

  tags       = local.tags
  extra_tags = local.extra_tags
}