variable "chart_name" {
  default     = "prometheus"
  description = "Name of the Helm chart that will be installed."
  type        = string
}

variable "chart_version" {
  default = ""
  description = "Version of the Helm chart version. Note that this is not the appVersion."
  type        = string
}

variable "create_namespace" {
  default     = false
  description = "If true, Terraform will create the namespace prior to installing the Helm chart."
  type        = bool
}

variable "enabled" {
  default     = true
  description = "If false, Terraform will not install/uninstall the Helm chart."
  type        = bool
}

variable "release_name" {
  default     = "prometheus"
  description = "Name of the Helm release that will be installed. If empty, the --generate-name parameter will be used."
  type        = string
}

variable "repository" {
  default     = "https://prometheus-community.github.io/helm-charts"
  description = "Url of the Helm chart repository."
  type        = string
}

variable "namespace" {
  default     = "default"
  description = "Namespace that is used to deploy the Helm chart into."
  type        = string
}

variable "alertmanager_persistence_storage_size" {
  default = "2Gi"
  description = "Storage size of the persistent volume for the alert manager."
  type = string
}

variable "server_persistence_storage_size" {
  default = "8Gi"
  description = "Storage size of the persistent volume for the server."
  type = string
}
