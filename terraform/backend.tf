terraform {
  backend "azurerm" {
    resource_group_name  = "rg-npd-tfstate"
    storage_account_name = "stnpdtfstatex"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}