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

# Private Load-Balancer With Private IP
# module "lb" {
#   source = "./modules/Networking/load-balancer"

#   resource_group_name = module.resource_group.name
#   location            = module.resource_group.location

#   lb_name            = "test-lb"
#   lb_type            = "private"
#   ft_name            = "lb-web-server"
#   lb_probes_port     = "80"
#   lb_probes_protocol = "Tcp"
#   lb_probes_path     = "/"
#   lb_nb_probes       = "2"
#   lb_rule_proto      = "Tcp"
#   lb_rule_ft_port    = "80"
#   lb_rule_bck_port   = "80"
#   ft_priv_ip_addr    = "10.0.0.9"

#   subnet_id = module.subnets["subnet1"].id

#   tags       = local.tags
#   extra_tags = local.extra_tags
# }



# Public Load-Balancer With Public IP
module "public_ip_address" {
  source = "./modules/Networking/public-ip"

  public_ip_name      = "test-pip"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  allocation_method   = "Static"
  sku                 = "Basic" # Change the SKU to Basic
  tags                = local.tags
  extra_tags          = local.extra_tags
}

module "lb" {
  source = "./modules/Networking/load-balancer"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  lb_name            = "test-lb"
  lb_type            = "public"
  ft_name            = "lb-web-server"
  lb_probes_port     = "80"
  lb_probes_protocol = "Tcp"
  lb_probes_path     = "/"
  lb_nb_probes       = "2"
  lb_rule_proto      = "Tcp"
  lb_rule_ft_port    = "80"
  lb_rule_bck_port   = "80"
  public_ip_id       = module.public_ip_address.id

  subnet_id = null

  tags       = local.tags
  extra_tags = local.extra_tags
}