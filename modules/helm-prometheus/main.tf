resource "helm_release" "prometheus" {
  count            = var.enabled ? 1 : 0

  name             = var.release_name
  namespace        = var.namespace

  chart            = var.chart_name
  create_namespace = var.create_namespace
  repository       = var.repository
  version          = var.chart_version

  values = [
    templatefile("${path.module}/templates/values.yaml.tftpl",
      {
        alertmanager_persistence_storage_size = var.alertmanager_persistence_storage_size
        server_persistence_storage_size = var.server_persistence_storage_size
      }
    )
  ]
}
