module "resource_group" {
  source = "./modules/Management/resource-group"

  resource_group_name = "test-rg-1"
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

module "network_interface" {
  source = "./modules/Networking/network-interface"

  network_interface_name        = "test-nic"
  resource_group_name           = module.resource_group.name
  location                      = module.resource_group.location
  ip_configuration_name         = "testconfiguration1"
  subnet_id                     = module.subnets["subnet1"].id
  private_ip_address_allocation = "Dynamic"
  private_ip_address            = "10.0.0.4"
  #  public_ip_address_id = module.public_ip_address.id
  public_ip_address_id = null
  tags                 = local.tags
  extra_tags           = local.extra_tags
}

module "application_gateway" {
  source = "./modules/Networking/application-gateway"

  application_gateway_name = "test-app-gateway"
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location

  sku = {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration_name = "test-gateway-ip-configuration"
  subnet_id = module.subnets["appgw"].id

  frontend_ip_configuration_name = "test-frontend-ip-configuration"
  public_ip_address_id = module.public_ip_address.id

  backend_address_pools = [
    {
      name = "test-backend-address-pool"
    }
  ]

  backend_http_settings = [
    {
      name                  = "test-http-settings"
      cookie_based_affinity = "Disabled"
      enable_https = true
      request_timeout       = 30
    }
  ]

  http_listeners = [
    {
      name                           = "test-http-listener"
      frontend_ip_configuration_name = "test-frontend-ip-configuration"
      frontend_port_name             = "test-frontend-port"
      protocol                       = "Http"
    }
  ]

  request_routing_rules = [
    {
      name                       = "test-request-routing-rule"
      rule_type                  = "Basic"
      http_listener_name         = "test-http-listener"
      backend_address_pool_name  = "test-backend-address-pool"
      backend_http_settings_name = "test-http-settings"
      priority                   = 1
    }
  ]

  tags       = local.tags
  extra_tags = local.extra_tags
}