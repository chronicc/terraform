locals {
  cluster_name = "${var.name}-${random_string.eks.result}"
}