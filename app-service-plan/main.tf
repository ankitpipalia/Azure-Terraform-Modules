resource "azurerm_service_plan" "App_Service_Plan" {
  for_each = var.App_Service_Plan_Config

  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  os_type             = each.value.os_type
  sku_name            = each.value.sku
  
}