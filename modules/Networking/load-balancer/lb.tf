# create and configure Azure Load Balancer

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge(
    {
      "Environment" = var.tags.environment,
      "Project"     = var.tags.project
    },
    var.extra_tags
  )

  frontend_ip_configuration {
    name                          = var.ft_name
    public_ip_address_id          = var.lb_type == "public" ? var.public_ip_id : null
    subnet_id                     = var.subnet_id
    private_ip_address            = var.lb_type == "private" ? var.ft_priv_ip_addr : null
    private_ip_address_allocation = var.lb_type == "private" ? var.ft_priv_ip_addr_alloc : "Dynamic"
  }
}


#---------------------------------------
# Backend address pool for Load Balancer
#---------------------------------------
resource "azurerm_lb_backend_address_pool" "bepool" {
  name                = "${azurerm_lb.lb.name}-bck-pool"
  loadbalancer_id     = azurerm_lb.lb.id
}

#---------------------------------------
# Load Balancer NAT pool
#---------------------------------------
resource "azurerm_lb_nat_pool" "natpol" {
  name                           = "${azurerm_lb.lb.name}-nat-pool"
  resource_group_name = var.resource_group_name
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port_start            = var.nat_pool_frontend_ports[0]
  frontend_port_end              = var.nat_pool_frontend_ports[1]
  backend_port                   = var.os_flavor == "linux" ? 22 : 3389
  frontend_ip_configuration_name = var.ft_name
}

#---------------------------------------
# Load Balancer NAT rule for SSH
#---------------------------------------
# resource "azurerm_lb_nat_rule" "natrule" {
#   name                           = "${azurerm_lb.lb.name}-nat-pool-rule"
#   resource_group_name            = var.resource_group_name
#   loadbalancer_id                = azurerm_lb.lb.id
#   protocol                       = "Tcp"
#   frontend_port_start            = var.nat_pool_frontend_ports[0]  # Specify the start port
#   frontend_port_end              = var.nat_pool_frontend_ports[1]  # Specify the end port
#   backend_port                   = var.os_flavor == "linux" ? 22 : 3389
#   frontend_ip_configuration_name = var.ft_name
#   backend_address_pool_id        = azurerm_lb_backend_address_pool.bepool.id
# }

#---------------------------------------
# Health Probe for resources
#---------------------------------------
resource "azurerm_lb_probe" "lbp" {
  name                = "${azurerm_lb.lb.name}-${var.lb_probes_port}-probe"
  loadbalancer_id     = azurerm_lb.lb.id
  port                = var.lb_probes_port
  protocol            = var.lb_probe_protocol
  request_path        = var.lb_probe_protocol != "Tcp" ? var.lb_probe_request_path : null
  number_of_probes    = var.lb_nb_probes
}

#--------------------------
# Load Balancer Rules
#--------------------------
resource "azurerm_lb_rule" "lbrule" {
  name                           = "${azurerm_lb.lb.name}-rule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = var.lb_rule_proto
  frontend_port                  = var.nat_pool_frontend_ports[0]
  backend_port                   = var.lb_rule_bck_port
  frontend_ip_configuration_name = var.ft_name
  probe_id                       = azurerm_lb_probe.lbp.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bepool.id]
  depends_on = [
    azurerm_lb_probe.lbp,
    azurerm_lb_backend_address_pool.bepool,
  ]
}

