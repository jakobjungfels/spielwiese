resource "azurerm_resource_group" "global" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "global" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.global.name
  location                 = azurerm_resource_group.global.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "global" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.global.name
  container_access_type = "private"
}