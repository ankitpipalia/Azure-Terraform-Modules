output "load_balancer_id" {
  description = "The ID of the Azure Load Balancer"
  value       = azurerm_lb.load_balancer.id
}

output "frontend_ip_configuration_id" {
  description = "The ID of the frontend IP configuration"
  value       = azurerm_lb_frontend_ip_configuration.load_balancer_frontend_ip_configuration.id
}

output "backend_address_pool_id" {
  description = "The ID of the backend address pool"
  value       = azurerm_lb_backend_address_pool.load_balancer_backend_address_pool.id
}

output "probe_id" {
  description = "The ID of the probe"
  value       = azurerm_lb_probe.load_balancer_probe.id
}

output "load_balancing_rule_id" {
  description = "The ID of the load balancing rule"
  value       = azurerm_lb_load_balancing_rule.load_balancer_load_balancing_rule.id
}
