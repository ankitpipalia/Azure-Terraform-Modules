output "id" {
  description = "The ID of the Application Insights instance"
  value       = azurerm_application_insights.application_insights.id
}

output "name" {
  description = "The name of the Application Insights instance"
  value       = azurerm_application_insights.application_insights.name
}

output "app_id" {
  description = "The App ID of the Application Insights instance"
  value       = azurerm_application_insights.application_insights.app_id
}

output "instrumentation_key" {
  description = "The Instrumentation Key of the Application Insights instance"
  value       = azurerm_application_insights.application_insights.instrumentation_key
}

output "connection_string" {
  description = "The Connection String of the Application Insights instance"
  value       = azurerm_application_insights.application_insights.connection_string
}
