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
      subnet_type = "subnet1" // The type of the subnet
      cidrs       = ["10.0.1.0/24"] // The CIDR block of the subnet
      ssh_port_open = true
      http_port_open = true
    }
    subnet2 = {
      subnet_type = "subnet2" // The type of the subnet
      cidrs       = ["10.0.2.0/24"] // The CIDR block of the subnet
      https_port_open = true
    }
  }
}

// Define the virtual machine module
module "virtual_machine" {
  count = 2
  source = "./virtual-machine" // The source of the module
  names = {
    environment  = "dev" // The environment name
    location     = "centralindia" // The location of the virtual machine
    project_name = "k8s-nodes" // The project name
  }
  resource_group_name = module.resource_group.name // The name of the resource group
  location            = "centralindia" // The location of the virtual machine
  tags = {
    environment = "dev" // The environment tag
    project     = "test" // The project tag
  }
  // Define the kernel type of the virtual machine
  kernel_type = "linux"

  // Define the instance size of the virtual machine
  virtual_machine_size = "Standard_B1ls"

  // Define the custom data of the virtual machine
  // custom_data = base64encode(file("${path.module}/example-file.sh"))

  // Define the operating system image of the virtual machine
  source_image_publisher = "Canonical"
  source_image_offer     = "0001-com-ubuntu-minimal-focal"
  source_image_sku       = "minimal-20_04-lts-gen2"
  source_image_version   = "latest"
  // Define the virtual network of the virtual machine
  subnet_id              = module.virtual_network.subnets["subnet1"].id
  public_ip_enabled      = true // Whether the public IP is enabled
  public_ip_sku          = "Standard" // The SKU of the public IP
  // Define the admin username and password for the virtual machine
  admin_username       = "testuser" // The username of the admin
  admin_ssh_public_key = file("~/.ssh/id_rsa.pub") // The SSH public key of the admin
}