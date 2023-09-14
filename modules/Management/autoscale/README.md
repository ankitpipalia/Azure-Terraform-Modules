# Azure Terraform Module for AutoScale Rule
This Terraform module creates an AutoScale rule for a VMSS, AKS, and App Service in Azure.

## Prerequisites

Before using this module, make sure you have the following:

- Azure subscription
- Terraform installed

## Usage

### Example: For VMSS

```hcl
module "autoscale_vmss" {
  source = "./modules/Management/autoscale"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  target_resource_id = module.vmss.vmss_id

  autoscale_setting_name = "test-vmss-autoscale"
  profile_name           = "test-vmss-autoscale-profile"

  default_capacity = 2
  minimum_capacity = 2
  maximum_capacity = 10

  metric_name      = "Percentage CPU"
  metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
  metric_resource_id = module.vmss.vmss_id
  time_grain       = "PT1M"
  statistic        = "Average"
  time_window      = "PT5M"
  time_aggregation = "Average"
  operator         = "GreaterThan"
  threshold        = 75

  scale_direction = "Increase"
  scale_type      = "ChangeCount"
  scale_value     = 1
  scale_cooldown  = "PT1M" 
}
```

## Inputs

| Name                                   | Description                                                                 | Type      | Default   | Required |
|----------------------------------------|-----------------------------------------------------------------------------|-----------|-----------|:--------:|
| `autoscale_setting_name`               | Name of the autoscale setting (if enabled).                                  | string    | -         | no       |
| `default_capacity`                     | Default capacity of the autoscale profile (if enabled).                     | number    | -         | no       |
| `location`                             | Azure location/region where the virtual machine will be created.           | string    | -         | yes      |
| `maximum_capacity`                     | Maximum capacity of the autoscale profile (if enabled).                     | number    | -         | no       |
| `metric_name`                          | Name of the metric trigger for autoscaling (if enabled).                    | string    | -         | no       |
| `metric_namespace`                     | Namespace of the metric trigger for autoscaling (if enabled).               | string    | -         | no       |
| `metric_resource_id`                   | Resource ID of the metric trigger for autoscaling (if enabled).             | string    | -         | no       |
| `minimum_capacity`                     | Minimum capacity of the autoscale profile (if enabled).                     | number    | -         | no       |
| `operator`                             | Operator for the metric trigger (if enabled).                               | string    | -         | no       |
| `profile_name`                         | Name of the autoscale profile (if enabled).                                  | string    | -         | no       |
| `resource_group_name`                  | Name of an existing resource group to be imported.                           | string    | -         | yes      |
| `scale_aggregation`                    | Aggregation method for the metric trigger (if enabled).                      | string    | -         | no       |
| `scale_cooldown`                       | Cooldown period for the scale action (if enabled).                          | string    | -         | no       |
| `scale_direction`                      | Direction of the scale action (if enabled).                                 | string    | -         | no       |
| `scale_type`                           | Type of the scale action (if enabled).                                      | string    | -         | no       |
| `scale_value`                          | Value of the scale action (if enabled).                                     | number    | -         | no       |
| `statistic`                            | Statistic for the metric trigger (if enabled).                              | string    | -         | no       |
| `target_resource_id`                   | Resource ID of the target resource for autoscaling (if enabled).            | string    | -         | no       |
| `threshold`                            | Threshold for the metric trigger (if enabled).                               | number    | -         | no       |
| `time_aggregation`                     | Time aggregation for the metric trigger (if enabled).                       | string    | -         | no       |
| `time_grain`                           | Time grain for the metric trigger (if enabled).                             | string    | -         | no       |
| `time_window`                          | Time window for the metric trigger (if enabled).                            | string    | -         | no       |