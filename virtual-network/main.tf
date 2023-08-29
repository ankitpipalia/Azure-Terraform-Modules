resource "azurerm_virtual_network" "vnet" {
  name                = "${var.names.project_name}-vnet"  # Define the name of the virtual network
  location            = var.location  # Define the location of the virtual network
  resource_group_name = var.resource_group_name  # Define the resource group of the virtual network
  address_space       = var.address_space  # Define the address space of the virtual network
  tags                = var.tags  # Define the tags of the virtual network
  dns_servers         = var.dns_servers  # Define the DNS servers of the virtual network
}

module "subnet" {
  source   = "./subnet"
  for_each = local.subnets

  names               = var.names  # Define the names of the subnets
  resource_group_name = var.resource_group_name  # Define the resource group of the subnets
  location            = var.location  # Define the location of the subnets
  tags                = var.tags  # Define the tags of the subnets

  naming_rules         = var.naming_rules  # Define the naming rules for the subnets
  enforce_subnet_names = local.enforce_subnet_names  # Define whether to enforce subnet names

  virtual_network_name = azurerm_virtual_network.vnet.name  # Define the virtual network name for the subnets
  subnet_type          = each.key  # Define the subnet type
  cidrs                = each.value.cidrs  # Define the CIDRs for the subnets

  enforce_private_link_endpoint_network_policies = each.value.enforce_private_link_endpoint_network_policies  # Define whether to enforce private link endpoint network policies
  enforce_private_link_service_network_policies  = each.value.enforce_private_link_service_network_policies  # Define whether to enforce private link service network policies

  service_endpoints = each.value.service_endpoints  # Define the service endpoints for the subnets
  delegations       = each.value.delegations  # Define the delegations for the subnets

  create_network_security_group = each.value.create_network_security_group  # Define whether to create a network security group for the subnets
  configure_nsg_rules           = each.value.configure_nsg_rules  # Define whether to configure NSG rules for the subnets
  allow_internet_outbound       = each.value.allow_internet_outbound  # Define whether to allow internet outbound for the subnets
  allow_lb_inbound              = each.value.allow_lb_inbound  # Define whether to allow load balancer inbound for the subnets
  allow_vnet_inbound            = each.value.allow_vnet_inbound  # Define whether to allow VNet inbound for the subnets
  allow_vnet_outbound           = each.value.allow_vnet_outbound   # Define whether to allow VNet outbound for the subnets
  ssh_port_open                 = each.value.ssh_port_open
  http_port_open                = each.value.http_port_open
  https_port_open               = each.value.https_port_open
}

resource "azurerm_route_table" "route_table" {
  for_each = var.route_tables

  name                          = "${var.resource_group_name}-${each.key}-routetable"  # Define the name of the route table
  location                      = var.location  # Define the location of the route table
  resource_group_name           = var.resource_group_name  # Define the resource group of the route table
  disable_bgp_route_propagation = each.value.disable_bgp_route_propagation  # Define whether to disable BGP route propagation

  dynamic "route" {
    for_each = (each.value.use_inline_routes ? each.value.routes : {})  # Define the routes for the route table
    content {
      name                   = route.key  # Define the name of the route
      address_prefix         = route.value.address_prefix  # Define the address prefix of the route
      next_hop_type          = route.value.next_hop_type  # Define the next hop type of the route
      next_hop_in_ip_address = try(route.value.next_hop_in_ip_address, null)  # Define the next hop IP address of the route
    }
  }

  tags = var.tags  # Define the tags of the route table
}

resource "azurerm_route" "non_inline_route" {
  for_each = local.non_inline_routes

  name                   = each.value.name  # Define the name of the route
  resource_group_name    = var.resource_group_name  # Define the resource group of the route
  route_table_name       = azurerm_route_table.route_table[each.value.table].name  # Define the route table name for the route
  address_prefix         = each.value.address_prefix  # Define the address prefix of the route
  next_hop_type          = each.value.next_hop_type  # Define the next hop type of the route
  next_hop_in_ip_address = try(each.value.next_hop_in_ip_address, null)  # Define the next hop IP address of the route
}

resource "azurerm_subnet_route_table_association" "association" {
  depends_on = [module.aks_subnet, azurerm_route_table.route_table]  # Define the dependencies of the association
  for_each   = local.route_table_associations  # Define the associations

  subnet_id      = module.subnet[each.key].id  # Define the subnet ID for the association
  route_table_id = azurerm_route_table.route_table[each.value].id  # Define the route table ID for the association
}

module "aks_subnet" {
  source   = "./subnet"
  for_each = local.aks_subnets

  names               = var.names  # Define the names of the AKS subnets
  resource_group_name = var.resource_group_name  # Define the resource group of the AKS subnets
  location            = var.location  # Define the location of the AKS subnets
  tags                = var.tags  # Define the tags of the AKS subnets

  enforce_subnet_names = false  # Define whether to enforce subnet names for the AKS subnets

  virtual_network_name = azurerm_virtual_network.vnet.name  # Define the virtual network name for the AKS subnets
  subnet_type          = each.key  # Define the subnet type for the AKS subnets
  cidrs                = each.value.cidrs  # Define the CIDRs for the AKS subnets

  enforce_private_link_endpoint_network_policies = each.value.enforce_private_link_endpoint_network_policies  # Define whether to enforce private link endpoint network policies for the AKS subnets
  enforce_private_link_service_network_policies  = each.value.enforce_private_link_service_network_policies  # Define whether to enforce private link service network policies for the AKS subnets

  service_endpoints = each.value.service_endpoints  # Define the service endpoints for the AKS subnets
  delegations       = each.value.delegations  # Define the delegations for the AKS subnets

  create_network_security_group = false  # Define whether to create a network security group for the AKS subnets
  configure_nsg_rules           = false  # Define whether to configure NSG rules for the AKS subnets
}

resource "azurerm_route_table" "aks_route_table" {
  for_each = local.aks_route_tables  # Define the AKS route tables

  lifecycle {
    ignore_changes = [tags]
  }

  name                          = "${var.resource_group_name}-aks-${each.key}-routetable"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = each.value.disable_bgp_route_propagation
}

resource "azurerm_route" "aks_route" {
  for_each = local.aks_routes

  name                   = each.value.name
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.aks_route_table[each.value.aks_id].name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = try(each.value.next_hop_in_ip_address, null)
}

resource "azurerm_subnet_route_table_association" "aks" {
  depends_on = [module.aks_subnet, azurerm_route_table.aks_route_table]
  for_each   = local.aks_subnets

  subnet_id      = module.aks_subnet[each.key].id
  route_table_id = azurerm_route_table.aks_route_table[each.value.aks_id].id
}

resource "azurerm_virtual_network_peering" "peer" {
  for_each = local.peers

  name                         = each.key
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.vnet.name
  remote_virtual_network_id    = each.value.id
  allow_virtual_network_access = each.value.allow_virtual_network_access
  allow_forwarded_traffic      = each.value.allow_forwarded_traffic
  allow_gateway_transit        = each.value.allow_gateway_transit
  use_remote_gateways          = each.value.use_remote_gateways
}