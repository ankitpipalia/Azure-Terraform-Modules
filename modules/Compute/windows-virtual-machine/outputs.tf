output "name" {
  description = "The name of the virtual machine"
  value       = azurerm_windows_virtual_machine.vm.name
}

output "id" {
  description = "The ID of the virtual machine"
  value       = azurerm_windows_virtual_machine.vm.id
}
