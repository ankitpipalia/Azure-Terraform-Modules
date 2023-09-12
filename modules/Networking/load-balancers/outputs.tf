output "load_balancer_id" {
  description = "the id for the azurerm_lb resource"
  value       = azurerm_lb.lb.id
}

output "load_balancer_backend_pool_id" {
  description = "the id for the azurerm_lb_backend_address_pool resource"
  value       = azurerm_lb_backend_address_pool.lb.id
}