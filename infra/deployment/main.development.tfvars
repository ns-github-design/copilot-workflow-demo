resource_group_name = "rg-ghcp-demo-dev"
location = "eastus"
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
key_vault_name = "kvghcpdev002"
tenant_id      = "2f03a96e-e5a4-421a-a3a1-965e62d578ad"
storage_account_name = "stghcpdev002"