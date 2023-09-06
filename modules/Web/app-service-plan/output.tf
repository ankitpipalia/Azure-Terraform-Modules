output "app_service_ids" {
  value = {
    for name, config in var.App_Service_Plan_Config :
    name => azurerm_service_plan.App_Service_Plan[name].id
  }
}