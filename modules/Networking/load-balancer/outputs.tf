output "load_balancer_id" {
  description = "the id for the azurerm_lb resource"
  value       = azurerm_lb.lb.id
}

output "load_balancer_backend_pool_id" {
  description = "the id for the azurerm_lb_backend_address_pool resource"
  value       = azurerm_lb_backend_address_pool.bepool.id
}

output "load_balancer_private_ip" {
  description = "The Private IP address allocated for load balancer"
  value       = azurerm_lb.lb.private_ip_address
}

output "load_balancer_nat_pool_id" {
  description = "The resource ID of the Load Balancer NAT pool."
  value       = azurerm_lb_nat_pool.natpol.id
}

output "load_balancer_health_probe_id" {
  description = "The resource ID of the Load Balancer health Probe."
  value       = azurerm_lb_probe.lbp.id
}

output "load_balancer_rules_id" {
  description = "The resource ID of the Load Balancer Rule"
  value       = azurerm_lb_rule.lbrule.id
}

