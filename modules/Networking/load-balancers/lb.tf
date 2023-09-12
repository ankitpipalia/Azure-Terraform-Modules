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

resource "azurerm_lb_probe" "lb" {
  name                = "${azurerm_lb.lb.name}-${var.lb_probes_port}-probe"
  loadbalancer_id     = azurerm_lb.lb.id
  protocol            = var.lb_probes_protocol
  port                = var.lb_probes_port
  request_path        = var.lb_probes_protocol == "Tcp" ? null : var.lb_probes_path
  number_of_probes    = var.lb_nb_probes
}

resource "azurerm_lb_rule" "lb" {
  name                           = "${azurerm_lb.lb.name}-rule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = var.lb_rule_proto
  frontend_port                  = var.lb_rule_ft_port
  backend_port                   = var.lb_rule_bck_port
  frontend_ip_configuration_name = var.ft_name
  probe_id                       = azurerm_lb_probe.lb.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb.id]
  depends_on = [
    azurerm_lb_probe.lb,
    azurerm_lb_backend_address_pool.lb,
  ]
}

resource "azurerm_lb_backend_address_pool" "lb" {
  name                = "${azurerm_lb.lb.name}-bck-pool"
  loadbalancer_id     = azurerm_lb.lb.id
}
