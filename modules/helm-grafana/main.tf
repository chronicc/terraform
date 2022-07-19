resource "helm_release" "grafana" {
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
        domain = var.ingress_domain
        persistence_enabled = true
        persistence_storage_class_name = ""
        persistence_storage_size = var.persistence_storage_size
      }
    )
  ]
}
