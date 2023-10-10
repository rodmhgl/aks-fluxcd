locals {
  cluster-name   = "aks-${var.suffix}"
  extension_name = "aks-${var.suffix}-fluxcd"
  dns_prefix     = "${local.cluster-name}-${azurerm_resource_group.this.name}-29f41"
}

resource "azurerm_kubernetes_cluster" "this" {
  name                      = local.cluster-name
  location                  = azurerm_resource_group.this.location
  resource_group_name       = azurerm_resource_group.this.name
  kubernetes_version        = "1.26.6"
  dns_prefix                = local.dns_prefix
  node_resource_group       = "MC_${azurerm_resource_group.this.name}_${local.cluster-name}_${azurerm_resource_group.this.location}"
  sku_tier                  = "Free"
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  tags                      = local.tags

  default_node_pool {
    name       = "default"
    vm_size    = "Standard_B4s_v2"
    node_count = 3
    tags       = local.tags
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "kubenet"
  }

}

resource "local_file" "kubeconfig" {
  filename = "mykubeconfig"
  content  = azurerm_kubernetes_cluster.this.kube_config_raw
}