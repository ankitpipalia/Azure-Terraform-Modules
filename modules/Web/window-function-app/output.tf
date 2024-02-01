output "window_function_name" {
  description = "The name of the Windows Function App"
  value       = azurerm_windows_function_app.example.name
}

output "resource_group_name" {
  description = "The name of the resource group where the Windows Function App is deployed"
  value       = azurerm_windows_function_app.example.resource_group_name
}

output "location" {
  description = "The Azure region in which the Windows Function App is deployed"
  value       = azurerm_windows_function_app.example.location
}

output "site_config" {
  description = "Configuration settings for the Windows Function App"
  value       = azurerm_windows_function_app.example.site_config
}

output "site_credentials" {
  description = "Credentials associated with the Windows Function App's site"
  value       = azurerm_windows_function_app.example.site_credential
}
