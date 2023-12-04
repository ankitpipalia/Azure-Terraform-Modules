output "backend_pool_ids" {
  description = "The ID's of the Azure Front Door Backend Pool"
  value       = azurerm_frontdoor.main.backend_pool.*.id
}

output "backend_pool_health_probes" {
  description = "The ID's of the Azure Front Door Backend Health Probe"
  value       = azurerm_frontdoor.main.backend_pool_health_probe.*.id
}

output "backend_pool_load_balancing" {
  description = "The ID of the Azure Front Door Backend Load Balancer"
  value       = azurerm_frontdoor.main.backend_pool_load_balancing.*.id
}

output "frontend_endpoint_id" {
  description = "The ID of the Azure Front Door Frontend Endpoint"
  value       = azurerm_frontdoor.main.frontend_endpoint.*.id
}

output "frontdoor_id" {
  description = "The ID of the FrontDoor"
  value       = azurerm_frontdoor.main.id
}

output "frontdoor_waf_policy_id" {
  description = "The ID of the FrontDoor Firewall Policy"
  value       = var.web_application_firewall_policy != null ? [for k in azurerm_frontdoor_firewall_policy.main : k.id] : null
}

output "frontdoor_waf_policy_location" {
  description = "The Azure Region where this FrontDoor Firewall Policy exists"
  value       = var.web_application_firewall_policy != null ? [for k in azurerm_frontdoor_firewall_policy.main : k.location] : null
}

output "frontdoor_waf_policy_frontend_endpoint_ids" {
  description = "The Frontend Endpoints associated with this Front Door Web Application Firewall policy"
  value       = var.web_application_firewall_policy != null ? [for k in azurerm_frontdoor_firewall_policy.main : k.frontend_endpoint_ids] : null
}