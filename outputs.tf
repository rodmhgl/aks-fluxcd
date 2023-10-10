output "aks_name" {
  value = azurerm_kubernetes_cluster.this.name
}

output "rg_name" {
  value = azurerm_resource_group.this.name
}

output "istio_ingress_ip" {
  value = data.kubernetes_service.this.status.0.load_balancer.0.ingress.0.ip
}

output "get_creds" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.this.name} --name ${azurerm_kubernetes_cluster.this.name} --admin"
}