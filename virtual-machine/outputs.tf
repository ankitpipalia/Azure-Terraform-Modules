output "vm_name" {
  description = "The name of the virtual machine"
  value       = azurerm_virtual_machine.vm.name
}

output "vm_id" {
  description = "The ID of the virtual machine"
  value       = azurerm_virtual_machine.vm.id
}

output "vm_ip_address" {
  description = "The IP address of the virtual machine"
  value       = azurerm_network_interface.vm_nic.private_ip_address
}

output "vm_public_ip_address" {
  description = "The public IP address of the virtual machine"
  value       = azurerm_network_interface.vm_nic.public_ip_address
}
