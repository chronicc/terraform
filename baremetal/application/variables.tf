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


## Gitlab Runner
##
variable "gitlab_runner_gitlab_url" {
  description = "Url of the Gitlab instance to which the runner connects"
  type        = string
}

variable "gitlab_runner_helm_chart" {
  description = "Name of the helm chart"
  type        = string
}

variable "gitlab_runner_helm_repository" {
  description = "Name of the helm repository"
  type        = string
}

variable "gitlab_runner_helm_version" {
  description = "Version of the helm chart"
  type        = string
}

variable "gitlab_runner_token" {
  description = "Registration token for the Gitlab instance"
  type        = string
}

variable "gitlab_runner_s3_cache_access_key" {
  description = "Access key for accessing the S3 cache bucket"
  type        = string
}

variable "gitlab_runner_s3_cache_address" {
  description = "Url to the S3 cache bucket"
  type        = string
}

variable "gitlab_runner_s3_cache_bucket_name" {
  description = "Name of the S3 cache bucket"
  type        = string
}

variable "gitlab_runner_s3_cache_enabled" {
  description = "If this is set to true, the S3 cache will be used"
  type        = bool
}

variable "gitlab_runner_s3_cache_region" {
  description = "Region where the S3 cache bucket resides in"
  type        = string
}

variable "gitlab_runner_s3_cache_secret_key" {
  description = "Secret key for accessing the S3 cache bucket"
  type        = string
}

## Minio
##
variable "minio_helm_chart" {
  description = "Name of the helm chart"
  type        = string
}

variable "minio_helm_repository" {
  description = "Name of the helm repository"
  type        = string
}

variable "minio_helm_version" {
  description = "Version of the helm chart"
  type        = string
}

variable "minio_ingress_host" {
  description = "Ingress route for the application"
  type        = string
}

variable "minio_root_password" {
  description = "Password for the root account"
  type        = string
}

variable "minio_storage_volume" {
  description = "Name of a persistent volume which will be used"
  type        = string
}

variable "minio_storage_size" {
  description = "Size of the persistent storage volume"
  type        = string
}