// Define the required providers for Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" // The source of the provider
      version = ">3" // The version of the provider
    }
  }
}

// Define the Azure provider
provider "azurerm" {
  features {} // Enable all features
  subscription_id = "8c874251-19f3-4632-814a-10696094b7bf" // The subscription ID for Azure
}

// Define the resource group module
module "resource_group" {
  source = "./resource-group" // The source of the module
  names = {
    environment  = "dev" // The environment name
    location     = "centralindia" // The location of the resource group
    project_name = "test" // The project name
  }
  location = "centralindia" // The location of the resource group
  tags = {
    environment = "dev" // The environment tag
    project     = "test" // The project tag
  }
  unique_name = "true" // Whether the name is unique
}

// Define the virtual network module
module "virtual_network" {
  source = "./virtual-network" // The source of the module
  names = {
    environment  = "dev" // The environment name
    location     = "centralindia" // The location of the virtual network
    project_name = "test" // The project name
  }
  resource_group_name = module.resource_group.name // The name of the resource group
  location            = "centralindia" // The location of the virtual network
  tags = {
    environment = "dev" // The environment tag
    project     = "test" // The project tag
  }
  enforce_subnet_names = false // Whether to enforce subnet names
  address_space        = ["10.0.0.0/16"] // The address space of the virtual network
  subnets = {
    subnet1 = {
      subnet_type = "aks1" // The type of the subnet
      cidrs       = ["10.0.1.0/24"] // The CIDR block of the subnet
    }
    subnet2 = {
      subnet_type = "aks2" // The type of the subnet
      cidrs       = ["10.0.2.0/24"] // The CIDR block of the subnet
    }
    
  }
}

// Define the network security rule for SSH
resource "azurerm_network_security_rule" "ssh" {
  name                        = "SSH" // The name of the rule
  priority                    = 1001 // The priority of the rule
  direction                   = "Inbound" // The direction of the rule
  access                      = "Allow" // The access of the rule
  protocol                    = "Tcp" // The protocol of the rule
  source_port_range           = "*" // The source port range of the rule
  destination_port_range      = "22" // The destination port range of the rule
  source_address_prefix       = "*" // The source address prefix of the rule
  destination_address_prefix  = "*" // The destination address prefix of the rule
  resource_group_name         = module.resource_group.name // The name of the resource group
  network_security_group_name = module.virtual_network.network_security_group_name // The name of the network security group
}

// Define the virtual machine module
module "virtual_machine" {
  source = "./virtual-machine" // The source of the module
  names = {
    environment  = "dev" // The environment name
    location     = "centralindia" // The location of the virtual machine
    project_name = "test" // The project name
  }
  resource_group_name = module.resource_group.name // The name of the resource group
  location            = "centralindia" // The location of the virtual machine
  tags = {
    environment = "dev" // The environment tag
    project     = "test" // The project tag
  }
  // Define the kernel type of the virtual machine
  kernel_type = "linux"

  // Define the instance name of the virtual machine
  linux_machine_name = "testing101"

  // Define the instance size of the virtual machine
  virtual_machine_size = "Standard_B1s"

  // Define the custom data of the virtual machine
  // custom_data = base64encode(file("${path.module}/example-file.sh"))

  // Define the operating system image of the virtual machine
  source_image_publisher = "Canonical"
  source_image_offer     = "UbuntuServer"
  source_image_sku       = "18.04-LTS"
  source_image_version   = "latest"
  // Define the virtual network of the virtual machine
  subnet_id              = module.virtual_network.subnets["subnet1"].id
  public_ip_enabled      = true // Whether the public IP is enabled
  public_ip_sku          = "Standard" // The SKU of the public IP

  admin_username       = "testuser" // The username of the admin
  admin_ssh_public_key = file("~/.ssh/id_rsa.pub") // The SSH public key of the admin
}



