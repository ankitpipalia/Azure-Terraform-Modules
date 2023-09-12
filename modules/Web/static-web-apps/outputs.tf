output "id" {
  value       = azurerm_static_site.static-site.id
  description = "The ID of the Static Site."
}

output "api_key" {
  value       = azurerm_static_site.static-site.api_key
  description = "The API Key of the Static Site."
}

output "default_host_name" {
  value       = azurerm_static_site.static-site.default_host_name
  description = "The Default Host Name of the Static Site."
}

output "identity" {
  value       = azurerm_static_site.static-site.identity[*]
  description = "The Managed Identity of the Static Site."
}