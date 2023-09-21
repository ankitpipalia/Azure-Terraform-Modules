locals {
  subnets = ["appgw", "subnet1", "subnet2"]
  tags = {
    environment = "Production"
    project     = "Project1"
  }
  extra_tags = {
    owner = "user1"
  }
}