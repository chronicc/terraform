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