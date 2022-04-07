variable "create_namespace" {
  description = "If this is set to true, the namespace will be created before the deployment"
  type        = bool
  default     = true
}

variable "enabled" {
  description = "If this is set to true, the module will be deployed"
  type        = bool
  default     = true
}

variable "helm_chart" {
  description = "Name of the helm chart"
  type        = string
}

variable "helm_repository" {
  description = "Name of the helm repository"
  type        = string
}

variable "helm_version" {
  description = "Version of the helm chart"
  type        = string
}

variable "ingress_host" {
  description = "Ingress route for the application"
  type        = string
}

variable "name" {
  description = "Name of the helm release"
  type        = string
}

variable "namespace" {
  description = "Namespace in which the helm release will be deployed"
  type        = string
}

variable "root_password" {
  description = "Password for the root account"
  type        = string
}

variable "storage_volume" {
  description = "Name of a persistent volume which will be used"
  type        = string
}

variable "storage_size" {
  description = "Size of the persistent storage volume"
  type        = string
}