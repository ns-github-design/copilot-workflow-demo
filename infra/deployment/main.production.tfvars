resource_group_name = "rg-ghcp-demo-prod"

location = "westeurope"

environment = "production"

tags = {
  workload    = "copilot-demo"
  environment = "production"
  owner       = "platform-team"
  costCenter  = "prod"
  criticality = "high"
}