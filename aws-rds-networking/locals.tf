locals {
  db_subnet_group_name        = var.db_subnet_group_name_prefix ? null : var.db_subnet_group_name
  db_subnet_group_name_prefix = var.db_subnet_group_name_prefix ? "${var.db_subnet_group_name}-" : null

  db_subnet_group_description = var.db_subnet_group_description
}
