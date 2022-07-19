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

variable "gitlab_url" {
  description = "Url of the Gitlab instance to which the runner connects"
  type        = string
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

variable "name" {
  description = "Name of the helm release"
  type        = string
}

variable "namespace" {
  description = "Namespace in which the helm release will be deployed"
  type        = string
}

variable "runner_token" {
  description = "Registration token for the Gitlab instance"
  type        = string
}

variable "s3_cache_access_key" {
  description = "Access key for accessing the S3 cache bucket"
  type        = string
}

variable "s3_cache_address" {
  description = "Url to the S3 cache bucket"
  type        = string
}

variable "s3_cache_bucket_name" {
  description = "Name of the S3 cache bucket"
  type        = string
}

variable "s3_cache_enabled" {
  description = "If this is set to true, the S3 cache will be used"
  type        = bool
  default     = false
}

variable "s3_cache_region" {
  description = "Region where the S3 cache bucket resides in"
  type        = string
}

variable "s3_cache_secret_key" {
  description = "Secret key for accessing the S3 cache bucket"
  type        = string
}