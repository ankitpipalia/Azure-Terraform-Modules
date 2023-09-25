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

module "public_ip_address" {
  source = "./modules/Networking/public-ip"

  public_ip_name      = "test-pip"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "firewall" {
  source = "./modules/Networking/firewall-tools/firewall"

  firewall_name       = "test-fw"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  use_management_ip_configuration = true

  ip_configuration = [
    {
      name                 = "test-ip-config"
      subnet_id            = module.subnets["subnet1"].id
      public_ip_address_id = module.public_ip_address.id
    }
  ]

  tags       = local.tags
  extra_tags = local.extra_tags
}

module "firewall-policy" {
  source              = "./modules/Networking/firewall-tools/policy"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  firewall_policy = {
    name                     = "example"
    sku                      = "Premium"
    private_ip_ranges        = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16", "100.64.0.0/10", "200.200.0.0/16"]
    threat_intelligence_mode = "Deny"
    threat_intelligence_allowlist = {
      ip_addresses = ["200.200.0.0/16"]
      fqdns        = ["example.com", "example.net"]
    }
  }

  tags       = local.tags
  extra_tags = local.extra_tags
}