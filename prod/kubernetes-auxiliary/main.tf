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
    file("helm-values/ingresscontroller.yml")
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

resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  namespace  = "cert-manager"

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