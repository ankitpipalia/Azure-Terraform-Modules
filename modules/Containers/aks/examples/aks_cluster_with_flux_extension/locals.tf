locals {
  subnets = flatten([
    {
      subnet_name           = "test-aks"
      subnet_address_prefix = "10.0.0.0/16"
    },
    {
      subnet_name           = "test-apim"
      subnet_address_prefix = "10.1.0.0/24"
    },
    {
      subnet_name           = "test-vm"
      subnet_address_prefix = "10.1.1.0/24"
    }
  ])
  tags = {
    environment = "Production"
    project     = "Project1"
  }
  extra_tags = {
    owner = "user1"
  }
}
