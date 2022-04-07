## Kubernetes Provider
##
variable "kubectl_context" {
  description = "Context which will be used by kubectl"
  type        = string
}

variable "kubectl_config_path" {
  description = "Path to the config file which will be used by kubectl"
  type        = string
  default     = "~/.kube/config"
}


## Ingress Controller
##
variable "ingress_controller_helm_chart" {
  description = "Name of the helm chart"
  type        = string
}

variable "ingress_controller_helm_repository" {
  description = "Name of the helm repository"
  type        = string
}

variable "ingress_controller_helm_version" {
  description = "Version of the helm chart"
  type        = string
}


## Certificate Manager
##
variable "cert_manager_helm_chart" {
  description = "Name of the helm chart"
  type        = string
}

variable "cert_manager_helm_repository" {
  description = "Name of the helm repository"
  type        = string
}

variable "cert_manager_helm_version" {
  description = "Version of the helm chart"
  type        = string
}

variable "cert_manager_issuer_email" {
  description = "Email which is used to issue certificates"
  type        = string
}


## Storage Configuration
##
variable "storage_local_volume_nodes" {
  description = "List of nodes providing local persistent volumes"
  type        = list(string)
}