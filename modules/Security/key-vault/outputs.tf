output "id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.key-vault.id
}

output "name" {
  description = "Name of key vault created."
  value       = azurerm_key_vault.key-vault.name
}

output "vault_uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value       = azurerm_key_vault.key-vault.vault_uri
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
  sensitive = true
}

output "role_assignment_id" {
  value = var.role_assignment ? azurerm_role_assignment.ra[0].id : ""
}

output "access_policy_id" {
  value = var.key_vault_access_policy ? azurerm_key_vault_access_policy.kvap[0].id : ""
}
