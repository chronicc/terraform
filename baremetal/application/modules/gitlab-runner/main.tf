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

resource "kubernetes_secret" "this" {
  metadata {
    name      = local.s3_cache_secret_name
    namespace = var.namespace
  }

  data = {
    username = var.s3_cache_access_key
    password = var.s3_cache_secret_key
  }

  type = "kubernetes.io/generic"
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
        gitlab_url           = var.gitlab_url,
        runner_token         = var.runner_token,
        s3_cache_address     = var.s3_cache_address,
        s3_cache_bucket_name = var.s3_cache_bucket_name,
        s3_cache_enabled     = var.s3_cache_enabled,
        s3_cache_region      = var.s3_cache_region,
        s3_cache_secret_name = local.s3_cache_secret_name,
    })}"
  ]

  depends_on = [
    kubernetes_namespace.this[0],
  ]
}