output "id" {
  value       = azurerm_static_site.Static_Web_App.id
  description = "The ID of the Static Site."
}

output "api_key" {
  value       = azurerm_static_site.Static_Web_App.api_key
  description = "The API Key of the Static Site."
}

output "default_host_name" {
  value       = azurerm_static_site.Static_Web_App.default_host_name
  description = "The Default Host Name of the Static Site."
}

output "identity" {
  value       = azurerm_static_site.Static_Web_App.identity[*]
  description = "The Managed Identity of the Static Site."
}

output "custom_domain_id" {
  value       = azurerm_static_site_custom_domain.Static_Web_App[*].id
  description = "The ID of the Custom Domain."
}

output "validation_token" {
  value       = var.validation_type == "dns-txt-token" ? azurerm_static_site_custom_domain.Static_Web_App[*].validation_token : null
  description = "The Validation Token of the Custom Domain."
}