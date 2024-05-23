terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.104.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-prod-sc-tfstate1153"
    storage_account_name = "stprodsctfstate1153"
    container_name       = "tfstate-core"
    key                  = "prod.terraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}
