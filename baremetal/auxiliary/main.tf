## Ingress Controller
##
resource "kubernetes_namespace" "ingress_controller" {
  metadata {
    name = "ingress-controller"
    annotations = {
      name = "ingress-controller"
    }
    labels = {
      managed_by = "terraform"
    }
  }
}

resource "helm_release" "ingress_controller" {
  name      = "ingress-controller"
  namespace = "ingress-controller"

  chart      = var.ingress_controller_helm_chart
  repository = var.ingress_controller_helm_repository
  version    = var.ingress_controller_helm_version

  values = [
    file("helm-values/ingress_controller.yml")
  ]

  depends_on = [
    kubernetes_namespace.ingress_controller
  ]
}


## Certificate Manager
##
resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
    annotations = {
      name = "cert-manager"
    }
    labels = {
      managed_by = "terraform"
    }
  }
}

resource "helm_release" "cert_manager" {
  name      = "cert-manager"
  namespace = "cert-manager"

  chart      = var.cert_manager_helm_chart
  repository = var.cert_manager_helm_repository
  version    = var.cert_manager_helm_version

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [
    kubernetes_namespace.cert_manager
  ]
}

resource "kubectl_manifest" "cluster_issuer_letsencrypt_staging" {
  yaml_body = <<-YAML
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: letsencrypt-staging
      namespace: cert-manager
    spec:
      acme:
        email: "${var.cert_manager_issuer_email}"
        privateKeySecretRef:
          name: letsencrypt-staging
        server: https://acme-staging-v02.api.letsencrypt.org/directory
        solvers:
        - http01:
            ingress:
              class: contour
    YAML

  depends_on = [
    helm_release.cert_manager
  ]
}

resource "kubectl_manifest" "cluster_issuer_letsencrypt_prod" {
  yaml_body = <<-YAML
    apiVersion: cert-manager.io/v1
    kind: ClusterIssuer
    metadata:
      name: letsencrypt-prod
      namespace: cert-manager
    spec:
      acme:
        email: "${var.cert_manager_issuer_email}"
        privateKeySecretRef:
          name: letsencrypt-prod
        server: https://acme-v02.api.letsencrypt.org/directory
        solvers:
        - http01:
            ingress:
              class: contour
    YAML

  depends_on = [
    helm_release.cert_manager
  ]
}


## Storage Class
##
resource "kubernetes_storage_class" "local" {
  metadata {
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = true
    }
    name = "local"
    labels = {
      "managed_by" = "terraform"
    }
  }

  allow_volume_expansion = true
  storage_provisioner    = "kubernetes.io/no-provisioner"
  volume_binding_mode    = "Immediate"
}


## Persistent Volumes
resource "kubernetes_persistent_volume" "local" {
  for_each = {
    "1" = "100Gi" # minio
    "2" = "8Gi"   # backstage
    "3" = "32Gi"  # grafana
    "4" = "32Gi"  # prometheus server
    "5" = "8Gi"   # prometheus alertmanager
  }

  metadata {
    name = "local-pv${each.key}"
  }

  spec {
    access_modes                     = ["ReadWriteOnce"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name               = kubernetes_storage_class.local.metadata[0].name

    capacity = {
      storage = each.value
    }

    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key      = "kubernetes.io/hostname"
            operator = "In"
            values   = var.storage_local_volume_nodes
          }
        }
      }
    }

    persistent_volume_source {
      local {
        path = "/mnt/volumes/pv${each.key}"
      }
    }
  }

  depends_on = [
    kubernetes_storage_class.local
  ]
}
