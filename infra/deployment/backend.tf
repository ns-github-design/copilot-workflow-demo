terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate-demo"
    storage_account_name = "sttfstatedemo001"
    container_name       = "tfstate"
    key                  = "development.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}