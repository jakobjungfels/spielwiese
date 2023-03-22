resource "azurerm_container_registry" "sw_kubernetes_docker_registry" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = true
}

resource "azurerm_role_assignment" "sw_registry_role_assignment" {
  principal_id                     = var.aks_service_principal_app_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.sw_kubernetes_docker_registry.id
  skip_service_principal_aad_check = true
}