output "addional_location" {
  description = "The additional location block info if specified"
  value       = azurerm_api_management.apim.additional_location
}

output "developer_portal_url" {
  description = "The developer portal URL of APIM"
  value       = azurerm_api_management.apim.developer_portal_url
}

output "gateway_regional_url" {
  description = "The regional gateway url of the APIM"
  value       = azurerm_api_management.apim.gateway_regional_url
}

output "gateway_url" {
  description = "The gateway url of the APIM"
  value       = azurerm_api_management.apim.gateway_url
}

output "hostname_configuration" {
  description = "The hostname configuration block if specified"
  value       = azurerm_api_management.apim.hostname_configuration
}

output "id" {
  description = "The id of the APIM"
  value       = azurerm_api_management.apim.id
}

output "name" {
  description = "The name of the APIM"
  value       = azurerm_api_management.apim.name
}

output "identity" {
  description = "The identity block of the APIM"
  value       = azurerm_api_management.apim.identity
}

output "management_api_url" {
  description = "The management API URL of APIM"
  value       = azurerm_api_management.apim.management_api_url
}

output "portal_url" {
  description = "The APIM portal URL"
  value       = azurerm_api_management.apim.portal_url
}

output "private_ip_addresses" {
  description = "The private IP addresses of the APIM"
  value       = azurerm_api_management.apim.private_ip_addresses
}

output "public_ip_addresses" {
  description = "The public IP addresses of the APIM instance"
  value       = azurerm_api_management.apim.public_ip_addresses
}

output "scm_url" {
  description = "The SCM URL of the APIM instance"
  value       = azurerm_api_management.apim.scm_url
}

output "tenant_access" {
  description = "The APIM tenant access block"
  value       = azurerm_api_management.apim.tenant_access
}
