# Terraform Module: azurerm_public_ip

This Terraform module creates an Azure public IP address.

## Usage

```hcl
module "public_ip" {
  source              = "path/to/module"
  public_ip_name      = "my-public-ip"
  location            = "eastus"
  resource_group_name = "my-resource-group"
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  tags                = {
    Environment = "Production"
    Department  = "IT"
  }
}

output "public_ip_address" {
  value = module.public_ip.public_ip_address
}
```

## Inputs

| Name                  | Description                                       | Type         | Default |
|-----------------------|---------------------------------------------------|--------------|---------|
| public_ip_name        | The name of the public IP                         | string       |         |
| location              | The location/region where the public IP will be created | string       |         |
| resource_group_name   | The name of the resource group where the public IP will be created | string       |         |
| allocation_method     | The allocation method for the public IP           | string       | Dynamic |
| sku                   | The SKU (pricing tier) for the public IP          | string       | Basic   |
| tags                  | Tags to apply to the public IP                    | map(string)  | {}      |

## Outputs

| Name                  | Description                                       |
|-----------------------|---------------------------------------------------|
| public_ip_address     | The public IP address                             |

