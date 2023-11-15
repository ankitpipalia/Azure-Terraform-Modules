output "principal_id" {
  value       = azurerm_user_assigned_identity.uai.principal_id
  description = "The Principal ID assigned to the user assigned identity."
}

output "client_id" {
  value       = azurerm_user_assigned_identity.uai.client_id
  description = "The Client ID assigned to the user assigned identity."
}

output "object_id" {
  value = azurerm_user_assigned_identity.uai.principal_id
}
