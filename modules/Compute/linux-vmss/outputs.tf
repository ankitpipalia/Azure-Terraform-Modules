output "vmss_id" {
  value = azurerm_linux_virtual_machine_scale_set.vmss.id
  description = "The id of the scale set" 
}

output "vmss_name" {
  value = azurerm_linux_virtual_machine_scale_set.vmss.name
  description = "The name of the scale set"
}

output "unique_vmss_id" {
  value = azurerm_linux_virtual_machine_scale_set.vmss.unique_id
  description = "The unique id of the scale set" 
}