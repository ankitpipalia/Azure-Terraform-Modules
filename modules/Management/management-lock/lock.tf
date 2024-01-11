resource "azurerm_management_lock" "management_lock" {
  name      = var.name
  scope     = var.scope 
  lock_level = var.lock_level

  notes = var.notes
}