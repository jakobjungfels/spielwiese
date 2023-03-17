terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "global"
    storage_account_name = "swglobaltfstatestorage"
    container_name       = "globaltfstate"
    key                  = "global.kubernetes.registry.tfstate"
  }
}

provider "azurerm" {
  features {}
}