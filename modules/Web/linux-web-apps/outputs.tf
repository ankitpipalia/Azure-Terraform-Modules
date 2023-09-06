output "web_app_id" {
  description = "The resource ID of the App Service component"
  value       = azurerm_linux_web_app.Web_App.id
}

output "outbound_ip_addresses" {
  description = "A comma separated list of outbound IP addresses"
  value       = azurerm_linux_web_app.Web_App.outbound_ip_addresses
}

output "outbound_ip_addresses_list" {
  description = "A comma separated list of outbound IP addresses"
  value       = azurerm_linux_web_app.Web_App.outbound_ip_address_list
}

output "identity" {
  description = "An identity block, which contains the Managed Service Identity information for this App Service."
  value       = azurerm_linux_web_app.Web_App.identity
}



