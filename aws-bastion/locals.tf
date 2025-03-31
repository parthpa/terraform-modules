locals {
  kube_cluster_name = "${var.environment}-${var.name}"
  default_tags = {
    Name = "${var.environment}-${var.name}-bastion-host"
  }
  tags                        = merge(local.default_tags, var.additional_tags)
}
