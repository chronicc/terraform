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
  }

  allow_volume_expansion = true
  reclaim_policy         = "Delete"
  storage_provisioner    = "kubernetes.io/no-provisioner"
  volume_binding_mode    = "WaitForFirstConsumer"
}