# Azure Terraform Module for Linux Virtual Machine

This Terraform module creates a Linux virtual machine in Azure. It includes all the necessary resources for production use, except for the resource group, virtual network, and subnet.

## Prerequisites

Before using this module, make sure you have the following:

- Azure subscription
- Terraform installed

## Usage

```hcl
module "virtual_machine" {
  source = "~/git/Azure-Terraform-Modules/modules/Compute/virtual-machine"

  virtual_machine_name = "test-vm"
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  vm_size = "Standard_B1ls"
  admin_username = "testadmin"
  admin_password = "Password1234!"
  network_interface_id = module.network_interface.id
  source_image_publisher = "Canonical"
  source_image_offer     = "0001-com-ubuntu-minimal-focal"
  source_image_sku       = "minimal-20_04-lts-gen2"
  source_image_version   = "latest"
  depends_on = [ module.network_interface ]

  tags = local.tags
  extra_tags = local.extra_tags
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| vm_name | The name of the virtual machine | string | | yes |
| location | The location/region where the virtual machine will be created | string | | yes |
| resource_group_name | The name of the resource group where the virtual machine will be created | string | | yes |
| vm_size | The size of the virtual machine | string | | yes |
| image_publisher | The publisher of the virtual machine image | string | | yes |
| image_offer | The offer of the virtual machine image | string | | yes |
| image_sku | The SKU of the virtual machine image | string | | yes |
| image_version | The version of the virtual machine image | string | | yes |
| os_disk_name | The name of the OS disk | string | | yes |
| os_disk_caching | The caching type of the OS disk | string | | yes |
| os_disk_create_option | The create option for the OS disk | string | | yes |
| os_disk_managed_disk_type | The managed disk type for the OS disk | string | | yes |
| os_disk_size_gb | The size of the OS disk in GB | number | | yes |
| computer_name | The computer name of the virtual machine | string | | yes |
| admin_username | The admin username for the virtual machine | string | | yes |
| admin_password | The admin password for the virtual machine | string | | yes |
| disable_password_authentication | Flag to disable password authentication for SSH | bool | | yes |
| ssh_key_path | The path to the SSH public key file | string | | yes |
| ssh_key_data | The SSH public key data | string | | yes |
| boot_diagnostics_enabled | Flag to enable boot diagnostics | bool | | yes |
| boot_diagnostics_storage_uri | The URI of the storage account for boot diagnostics | string | | yes |
| tags | Tags to apply to the virtual machine | map(string) | | yes |
| nic_name | The name of the network interface | string | | yes |
| ip_configuration_name | The name of the IP configuration | string | | yes |
| subnet_id | The ID of the subnet | string | | yes |
| private_ip_address_allocation | The private IP address allocation method | string | | yes |
| private_ip_address | The private IP address | string | | yes |
| public_ip_address_id | The ID of the public IP address | string | | yes |

## Outputs

| Name | Description |
|------|-------------|
| vm_name | The name of the virtual machine |
| vm_id | The ID of the virtual machine |
| vm_ip_address | The IP address of the virtual machine |
| vm_public_ip_address | The public IP address of the virtual machine |
