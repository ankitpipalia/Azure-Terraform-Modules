# Azure Terraform Module for Linux Virtual Machine

This Terraform module creates a Linux virtual machine Scale Set in Azure. It includes all the necessary resources for production use, except for the resource group, virtual network, and subnet.

## Prerequisites

Before using this module, make sure you have the following:

- Azure subscription
- Terraform installed

## Usage

```hcl
module "vmss" {
  source = "./modules/Compute/linux-vmss"

  virtual_machine_scale_set_name = "test-vmss"
  resource_group_name            = module.resource_group.name
  location                       = module.resource_group.location
  vm_sku                         = "Standard_B1ls"
  instances                      = 2
  admin_username                 = "azureuser"
  admin_password                 = "P@ssw0rd1234!"

  source_image_publisher = "Canonical"
  source_image_offer     = "0001-com-ubuntu-minimal-focal"
  source_image_sku       = "minimal-20_04-lts-gen2"
  source_image_version   = "latest"

  subnet_id = module.subnets["subnet1"].id
  
  enable_load_balancer_backend_address_pool_ids = true
  load_balancer_backend_address_pool_ids = [module.lb.load_balancer_backend_pool_id]

  tags       = local.tags
  extra_tags = local.extra_tags
}
```

## Inputs

| Name                                   | Description                                                                 | Type      | Default   | Required |
|----------------------------------------|-----------------------------------------------------------------------------|-----------|-----------|:--------:|
| `admin_password`                       | Admin Password for the virtual machines.                                    | string    | -         | yes      |
| `admin_ssh_public_key`                 | Public SSH Key for authentication (optional).                               | string    | ""        | no       |
| `admin_username`                       | Default Username for the virtual machines.                                  | string    | -         | yes      |
| `application_gateway_backend_address_pool_ids`| Application gateway backend address pool ids (if any).                      | list(string)| -         | no       |
| `custom_data`                          | Custom data to be passed to the virtual machines.                           | string    | "# noop"  | no       |
| `enable_health_probe_id`               | Enables health check probe id for Scale Set.                                | bool      | false     | no       |
| `enable_public_ip_address`             | Enable or disable the assignment of public IP addresses to virtual machines. | bool      | false     | no       ||
| `enable_load_balancer_backend_address_pool_ids`| Enable or disable the assignment of load balancer backend address pool ids to virtual machines. | bool      | false     | no       |
| `enable_application_gateway_backend_address_pool_ids`| Enable or disable the assignment of application gateway backend address pool ids to virtual machines. | bool      | false     | no       |
| `extra_tags`                           | Extra tags to be applied to resources (in addition to the tags above).      | map(string)| {}        | no       |
| `health_probe_id`                      | Health probe id (if enabled).                                               | string    | null      | no       |
| `identity_ids`                         | List of user-managed identity ids to be assigned to the VM.                 | list(string)| []        | no       |
| `identity_type`                        | Managed Service Identity Type of the Virtual Machine.                       | string    | "SystemAssigned" | no  |
| `instances`                            | Number of instances in the VMSS.                                            | number    | -         | yes      |
| `location`                             | Azure location/region where the virtual machine will be created.           | string    | -         | yes      |
| `load_balancer_backend_address_pool_ids`| Load balancer backend address pool ids (if any).                            | list(string)| -         | no       |
| `nat_gateway_name`                     | Name of NAT Gateway.                                                         | string    | -         | yes      |
| `nat_idle_time`                        | Idle timeout (in seconds) of the NAT Gateway.                               | number    | 10        | no       |
| `nat_sku`                              | SKU (Service Level) of the NAT Gateway.                                     | string    | "Standard"| no       |
| `nat_zones`                            | List of availability zones for the NAT Gateway.                             | list(string)| []        | no       |
| `public_ip_address_id`                 | ID of the associated public IP address.                                     | string    | -         | yes      |
| `resource_group_name`                  | Name of an existing resource group to be imported.                           | string    | -         | yes      |
| `source_image_id`                      | Operating System Image ID.                                                  | string    | null      | no       |
| `source_image_offer`                   | Operating System Name.                                                       | string    | null      | no       |
| `source_image_publisher`               | Operating System Publisher.                                                  | string    | null      | no       |
| `source_image_sku`                     | Operating System SKU.                                                        | string    | null      | no       |
| `source_image_version`                 | Operating System Version.                                                    | string    | null      | no       |
| `subnet_id`                            | Subnet id for Scale Set.                                                     | string    | -         | yes      |
| `tags`                                 | Tags to be applied to resources (inclusive).                                 | object    | -         | yes      |
|                                        | - `environment`: Environment tag.                                            | string    | -         | yes      |
|                                        | - `project`: Project tag.                                                    | string    | -         | yes      |
| `virtual_machine_scale_set_name`       | Virtual Machine ScaleSet name.                                               | string    | -         | yes      |
| `vm_sku`                               | Size of the virtual machines.                                                | string    | -         | yes      |

## Outputs

| Name             | Description                                   | Type   |
|------------------|-----------------------------------------------|--------|
| `vmss_id`        | The id of the scale set.                     | string |
| `vmss_name`      | The name of the scale set.                   | string |
| `unique_vmss_id` | The unique id of the scale set.              | string |
