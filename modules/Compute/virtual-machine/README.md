# Azure Terraform Module for Linux Virtual Machine

This Terraform module creates a Linux virtual machine in Azure. It includes all the necessary resources for production use, except for the resource group, virtual network, and subnet.

## Prerequisites

Before using this module, make sure you have the following:

- Azure subscription
- Terraform installed

## Usage

```hcl
module "vm" {
  source                = "path/to/module"
  vm_name               = "my-vm"
  location              = "eastus"
  resource_group_name   = "my-resource-group"
  vm_size               = "Standard_DS2_v2"
  image_publisher       = "Canonical"
  image_offer           = "UbuntuServer"
  image_sku             = "18.04-LTS"
  image_version         = "latest"
  os_disk_name          = "my-os-disk"
  os_disk_caching       = "ReadWrite"
  os_disk_create_option = "FromImage"
  os_disk_managed_disk_type = "Standard_LRS"
  os_disk_size_gb       = 30
  computer_name         = "my-vm"
  admin_username        = "adminuser"
  admin_password        = "adminpassword"
  disable_password_authentication = false
  ssh_key_path          = "~/.ssh/id_rsa.pub"
  ssh_key_data          = ""
  boot_diagnostics_enabled = true
  boot_diagnostics_storage_uri = "https://mystorageaccount.blob.core.windows.net/"
  tags = {
    Environment = "Production"
    Department  = "IT"
  }
  nic_name              = "my-nic"
  ip_configuration_name = "my-ip-config"
  subnet_id             = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/my-resource-group/providers/Microsoft.Network/virtualNetworks/my-vnet/subnets/my-subnet"
  private_ip_address_allocation = "Dynamic"
  private_ip_address    = ""
  public_ip_address_id  = ""
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
