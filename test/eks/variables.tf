variable "name" {
  default = "eks"
  description = "Name of the cluster which is used for all resourcs related to EKS."
  type = string
}

resource "random_string" "eks" {
  length  = 8
  special = false
}

variable "profile" {
  default     = ""
  description = "AWS cli profile"
  type        = string
}

variable "region" {
  default     = ""
  description = "AWS region"
  type        = string
}

locals {
  cluster_name = "${var.name}-${random_string.eks.result}"
}