data "aws_partition" "current" {}

resource "random_id" "snapshot_identifier" {
  count = var.create && !var.skip_final_snapshot ? 1 : 0

  keepers = {
    id = var.cluster_identifier
  }

  byte_length = 4
}

resource "aws_rds_cluster" "rds_cluster" {
  count = var.create ? 1 : 0

  cluster_identifier = var.cluster_identifier

  engine            = var.engine
  engine_version    = var.engine_version
  db_cluster_instance_class    = var.db_cluster_instance_class
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type
  storage_encrypted = var.storage_encrypted
  kms_key_id        = var.kms_key_id

  database_name                             = var.database_name
  master_username                            = var.master_username
  master_password                            = var.master_password
  port                                = var.port
  
  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = var.db_subnet_group_name
  db_cluster_parameter_group_name   = try(aws_db_parameter_group.this[0].id, null)
  
  network_type           = var.network_type

  iops                = var.iops

  allow_major_version_upgrade = var.allow_major_version_upgrade
  apply_immediately           = var.apply_immediately
  preferred_maintenance_window          = var.preferred_maintenance_window

  snapshot_identifier       = var.snapshot_identifier
  copy_tags_to_snapshot     = var.copy_tags_to_snapshot
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = local.final_snapshot_identifier
  
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  deletion_protection      = var.deletion_protection

  tags = var.tags

  depends_on = [aws_cloudwatch_log_group.this]


}

resource "aws_cloudwatch_log_group" "this" {
  for_each = toset([for log in var.enabled_cloudwatch_logs_exports : log if var.create && var.create_cloudwatch_log_group])

  name              = "/aws/rds/instance/${var.cluster_identifier}/${each.value}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  kms_key_id        = var.cloudwatch_log_group_kms_key_id

  tags = var.tags
}

data "aws_iam_policy_document" "enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_db_parameter_group" "this" {
  count = var.create_param_group ? 1 : 0

  name        = local.param_group_name
  name_prefix = local.param_group_name_prefix
  description = local.param_group_description
  family      = var.family

  tags = merge(
    var.tags,
    {
      "Name" = var.param_group_name
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}
