terraform {
  required_version = "~> 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0"
    }
  }
}

provider "azurerm" {
  features {}
}
