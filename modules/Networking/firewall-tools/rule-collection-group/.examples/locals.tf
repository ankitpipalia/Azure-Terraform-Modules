locals {
  subnets = ["subnet1", "subnet2", "subnet3"]
  tags = {
    environment = "Production"
    project     = "Project1"
  }
  extra_tags = {
    owner = "user1"
  }
  local_subnet = "10.0.0.0/8"
  adds_servers = ["10.0.0.4", "10.0.0.5"]
}