## Kubernetes Provider
##
variable "kubectl_context" {
  description = "Context which will be used by kubectl"
  type        = string
}

variable "kubectl_config_path" {
  default     = "~/.kube/config"
  description = "Path to the config file which will be used by kubectl"
  type        = string
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