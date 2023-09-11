output "id" {
  value       = azurerm_linux_web_app.lwa.id
  description = "Linux Web App ID"
}

output "identity" {
  value       = azurerm_linux_web_app.lwa.identity[*]
  description = "Linux Web App Managed Identity"
}

output "default_hostname" {
  value       = azurerm_linux_web_app.lwa.default_hostname
  description = "Linux Web App default hostname"
}