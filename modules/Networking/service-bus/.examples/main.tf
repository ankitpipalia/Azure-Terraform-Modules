module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location            = "centralindia"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "redis" {
  source = "./modules/Storage/redis-cache"

  cache_name      = "my-redis-cache"
  location        = module.resource_group.location
  resource_group_name = module.resource_group.name
  capacity        = 0
  family          = "C"
  sku             = "Basic"
  public_network_access_enabled  = true
  redis_version                  = "6"
  enable_non_ssl_port            = true
  minimum_tls_version            = "1.2"
  cluster_shard_count            = 0

  tags                = local.tags
  extra_tags          = local.extra_tags
}