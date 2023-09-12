resource "azurerm_lb" "load_balancer" {
  name                = var.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.load_balancer_sku

  frontend_ip_configuration {
    name                          = var.frontend_ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address            = var.private_ip_address
  }

  backend_address_pool {
    name = var.backend_address_pool_name
  }

  probe {
    name                      = var.probe_name
    protocol                  = var.probe_protocol
    port                      = var.probe_port
    interval                  = var.probe_interval
    number_of_probes          = var.probe_number_of_probes
    request_path              = var.probe_request_path
    protocol_match            = var.probe_protocol_match
    ignore_https_server_name  = var.probe_ignore_https_server_name
    match_body                = var.probe_match_body
    match_status_codes        = var.probe_match_status_codes
    min_servers               = var.probe_min_servers
    max_servers               = var.probe_max_servers
    healthy_http_response     = var.probe_healthy_http_response
    unhealthy_http_response   = var.probe_unhealthy_http_response
    healthy_http_response_win = var.probe_healthy_http_response_win
    unhealthy_http_response_win = var.probe_unhealthy_http_response_win
  }

  load_balancing_rule {
    name               = var.load_balancing_rule_name
    frontend_port      = var.load_balancing_rule_frontend_port
    backend_port       = var.load_balancing_rule_backend_port
    protocol           = var.load_balancing_rule_protocol
    backend_address_pool_id = azurerm_lb_backend_address_pool.load_balancer_backend_address_pool.id
    probe_id           = azurerm_lb_probe.load_balancer_probe.id
  }

  tags = var.tags
}
