output "admin_user" {
    value = azurerm_container_registry.sw_kubernetes_docker_registry.admin_username
}

output "admin_password" {
    value = azurerm_container_registry.sw_kubernetes_docker_registry.admin_password
    sensitive = true
}