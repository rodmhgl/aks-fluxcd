locals {
  tags = {
    lab = "aks-fluxcd"
    env = "dev"
  }
  rg-name        = "rg-${var.suffix}"
}

resource "azurerm_resource_group" "this" {
  name     = local.rg-name
  location = var.location
  tags     = local.tags
}
