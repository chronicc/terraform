variable "name" {
  description = "Name of the cluster which is used for all resourcs related to EKS."
  type = string
  default = "eks"
}

resource "random_string" "eks" {
  length  = 8
  special = false
}

variable "profile" {
  description = "AWS profile"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}