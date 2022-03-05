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


## Example Applications
##
variable "basic_example_host" {
  description = "Host for the basic example application"
  type        = string
}

variable "cert_example_host" {
  description = "Host for the certificate example application"
  type        = string
}