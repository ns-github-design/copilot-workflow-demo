resource_group_name = "rg-ghcp-demo-dev"
location = "westeurope"
tags = {
  workload    = "copilot-demo"
  environment = "development"
  owner       = "platform-team"
  costCenter  = "demo"
}
vnet_name = "vnet-copilot-dev"
subnet_name = "subnet-default"
subnet_address_prefixes = ["10.0.1.0/24"]
nsg_name          = "nsg-copilot-dev"
route_table_name  = "rt-copilot-dev"
