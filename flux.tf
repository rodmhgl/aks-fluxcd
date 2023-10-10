locals {
  git_url = "https://github.com/${var.gh_user}/${var.repo_name}"
}

resource "azurerm_kubernetes_cluster_extension" "this" {
  name              = local.extension_name
  cluster_id        = azurerm_kubernetes_cluster.this.id
  extension_type    = "microsoft.flux"
  release_namespace = "flux-system"
}

resource "azurerm_kubernetes_flux_configuration" "this" {
  name                              = "aks-store-demo"
  scope                             = "cluster"
  namespace                         = azurerm_kubernetes_cluster_extension.this.release_namespace
  cluster_id                        = azurerm_kubernetes_cluster.this.id
  continuous_reconciliation_enabled = true

  git_repository {
    url                      = local.git_url
    reference_type           = "branch"
    reference_value          = var.repo_branch
    sync_interval_in_seconds = 60
  }

  kustomizations {
    name                       = "dev"
    path                       = "./overlays/dev"
    garbage_collection_enabled = true
    recreating_enabled         = true
    sync_interval_in_seconds   = 60
  }

}
