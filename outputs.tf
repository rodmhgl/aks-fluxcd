output "aks_name" {
  value = azurerm_kubernetes_cluster.this.name
}

output "rg_name" {
  value = azurerm_resource_group.this.name
}

output "get_creds" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.this.name} --name ${azurerm_kubernetes_cluster.this.name} --admin"
}