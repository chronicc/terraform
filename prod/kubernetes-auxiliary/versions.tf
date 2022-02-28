terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.4.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.8.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "helm" {
  kubernetes {
    config_path    = var.kubectl_config_path
    config_context = var.kubectl_context
  }
}

provider "kubernetes" {
  config_path    = var.kubectl_config_path
  config_context = var.kubectl_context
}