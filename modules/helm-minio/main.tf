resource "kubernetes_namespace" "this" {
  count = var.enabled && var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace
    annotations = {
      name = var.namespace
    }
    labels = {
      managed_by = "terraform"
    }
  }
}

resource "kubernetes_persistent_volume_claim" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.name
    namespace = var.namespace
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = var.storage_size
      }
    }
    volume_name = var.storage_volume
  }
}

resource "helm_release" "this" {
  count = var.enabled ? 1 : 0

  name      = var.name
  namespace = var.namespace

  chart      = var.helm_chart
  repository = var.helm_repository
  version    = var.helm_version

  values = [
    "${templatefile("${path.module}/templates/values.yaml.tftpl",
      {
        ingress_host  = var.ingress_host,
        root_password = var.root_password,
        storage_claim = kubernetes_persistent_volume_claim.this[0].metadata[0].name
        storage_size  = var.storage_size,
    })}"
  ]

  depends_on = [
    kubernetes_namespace.this[0],
  ]
}