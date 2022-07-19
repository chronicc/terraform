## Basic Example Application
##
resource "kubectl_manifest" "basic_example_app" {
  yaml_body = <<-YAML
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      creationTimestamp: null
      labels:
        app: mando
      name: mando
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: mando
      strategy: {}
      template:
        metadata:
          creationTimestamp: null
          labels:
            app: mando
        spec:
          containers:
          - image: downey/mando
            name: mando
            imagePullPolicy: Always
            ports:
            - containerPort: 8080
            env:
            - name: PORT
              value: "8080"
    YAML
}

resource "kubectl_manifest" "basic_example_service" {
  yaml_body = <<-YAML
    apiVersion: v1
    kind: Service
    metadata:
      labels:
        app: mando
      name: mando
    spec:
      ports:
      - name: http
        port: 80
        protocol: TCP
        targetPort: 8080
      selector:
        app: mando
      type: ClusterIP
    YAML
}

resource "kubectl_manifest" "basic_example_ingress" {
  yaml_body = <<-YAML
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: mando
      annotations:
        kubernetes.io/ingress.class: "contour"
    spec:
      rules:
      - host: "${var.basic_example_host}"
        http:
          paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: mando
                port:
                  number: 80
    YAML
}


## Certificate Example Application
##
resource "kubectl_manifest" "cert_example_app" {
  yaml_body = <<-YAML
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: name-generator
    spec:
      selector:
        matchLabels:
          app: name-generator
      replicas: 1
      template:
        metadata:
          labels:
            app: name-generator
        spec:
          containers:
          - image: tomdesinto/name-generator
            imagePullPolicy: Always
            name: name-generator
            ports:
            - containerPort: 10010
    YAML
}

resource "kubectl_manifest" "cert_example_service" {
  yaml_body = <<-YAML
    apiVersion: v1
    kind: Service
    metadata:
      name: name-generator
    spec:
      ports:
      - port: 80
        targetPort: 10010
        protocol: TCP
      selector:
        app: name-generator
    YAML
}

resource "kubectl_manifest" "cert_example_ingress" {
  yaml_body = <<-YAML
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: name-generator
      annotations:
        cert-manager.io/cluster-issuer: letsencrypt-prod
        ingress.kubernetes.io/force-ssl-redirect: "true"
        kubernetes.io/ingress.class: "contour"
        kubernetes.io/tls-acme: "true"
    spec:
      tls:
      - secretName: cert-example-tls
        hosts:
        - "${var.cert_example_host}"
      rules:
      - host: "${var.cert_example_host}"
        http:
          paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: name-generator
                port:
                  number: 80
    YAML
}


## Gitlab Runner
##
module "gitlab_runner" {
  source    = "./modules/gitlab-runner"
  name      = "gitlab-runner"
  namespace = "gitlab-runner"

  gitlab_url           = var.gitlab_runner_gitlab_url
  helm_chart           = var.gitlab_runner_helm_chart
  helm_repository      = var.gitlab_runner_helm_repository
  helm_version         = var.gitlab_runner_helm_version
  runner_token         = var.gitlab_runner_token
  s3_cache_access_key  = var.gitlab_runner_s3_cache_access_key
  s3_cache_address     = var.gitlab_runner_s3_cache_address
  s3_cache_bucket_name = var.gitlab_runner_s3_cache_bucket_name
  s3_cache_enabled     = var.gitlab_runner_s3_cache_enabled
  s3_cache_region      = var.gitlab_runner_s3_cache_region
  s3_cache_secret_key  = var.gitlab_runner_s3_cache_secret_key
}


## Grafana
##
module "helm_grafana" {
  source = "../../modules/helm-grafana"

  ingress_domain           = var.grafana_ingress_domain
  persistence_storage_size = "32Gi"
}

resource "kubernetes_config_map" "grafana_dashboards" {
  metadata {
    name = "grafana-dashboards"
    labels = {
      "grafana_dashboard" = "1"
    }
  }

  data = {
    "kubernetes.json" = "${file("${path.module}/files/grafana_dashboard_kubernetes.json")}"
  }
}


## Minio
##
module "minio" {
  source    = "./modules/minio"
  name      = "minio"
  namespace = "minio"

  helm_chart      = var.minio_helm_chart
  helm_repository = var.minio_helm_repository
  helm_version    = var.minio_helm_version
  ingress_host    = var.minio_ingress_host
  root_password   = var.minio_root_password
  storage_size    = var.minio_storage_size
  storage_volume  = var.minio_storage_volume
}


## Prometheus
##
module "helm_prometheus" {
  source = "../../modules/helm-prometheus"

  alertmanager_persistence_storage_size = "8Gi"
  server_persistence_storage_size       = "32Gi"
}
