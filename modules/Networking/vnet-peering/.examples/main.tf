module "resource_group_1" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location            = "centralindia"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "resource_group_2" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg"
  location            = "centralindia"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "virtual_network_1" {
  source = "./modules/Networking/virtual-network"

  virtual_network_name = "test-vne-1"
  location             = module.resource_group_1.location
  resource_group_name  = module.resource_group_1.name
  address_space        = ["10.0.0.0/16"]
  tags                 = local.tags
  extra_tags           = local.extra_tags
}

module "subnets_1" {
  source = "./modules/Networking/subnets"

  for_each              = toset(local.subnets)
  subnet_name           = each.value
  resource_group_name   = module.resource_group_1.name
  virtual_network_name  = module.virtual_network_1.name
  subnet_address_prefix = cidrsubnet(module.virtual_network_1.address_space[0], 8, index(local.subnets, each.value)) # Ensure unique address for each subnet
  # For example, if you're given a prefix ending in /16 and you want your subnets to have a prefix of /20, then newbits would be 4, because 20 - 16 = 4
}

module "virtual_network_2" {
  source = "./modules/Networking/virtual-network"

  virtual_network_name = "test-vnet-2"
  location             = module.resource_group_2.location
  resource_group_name  = module.resource_group_2.name
  address_space        = ["10.1.0.0/16"]
  tags                 = local.tags
  extra_tags           = local.extra_tags
}

module "subnets_2" {
  source = "./modules/Networking/subnets"

  for_each              = toset(local.subnets)
  subnet_name           = each.value
  resource_group_name   = module.resource_group_2.name
  virtual_network_name  = module.virtual_network_2.name
  subnet_address_prefix = cidrsubnet(module.virtual_network_2.address_space[0], 8, index(local.subnets, each.value)) # Ensure unique address for each subnet
  # For example, if you're given a prefix ending in /16 and you want your subnets to have a prefix of /20, then newbits would be 4, because 20 - 16 = 4
}

module "vnet_peer" {
  source = "./modules/Networking/vnet-peering"

  src_resource_group_name = module.resource_group_1.name
  dst_resource_group_name = module.resource_group_2.name

  src_virtual_network_name = module.virtual_network_1.name
  dst_virtual_network_name = module.virtual_network_2.name

  src_virtual_network_id = module.virtual_network_1.id
  dst_virtual_network_id = module.virtual_network_2.id

  src_peering_name = "vnet-peer-1"
  dst_peering_name = "vnet-peer-2"

  allow_virtual_network_access = true
}