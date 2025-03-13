locals {
  param_group_name        = var.param_group_name_prefix ? null : var.param_group_name
  param_group_name_prefix = var.param_group_name_prefix ? "${var.param_group_name}-" : null

  param_group_description = var.param_group_description

  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.final_snapshot_identifier_prefix}-${var.cluster_identifier}-${try(random_id.snapshot_identifier[0].hex, "")}"

  cluster_identifier        = var.use_identifier_prefix ? null : var.cluster_identifier
  cluster_identifier_prefix = var.use_identifier_prefix ? "${var.cluster_identifier}-" : null
}
