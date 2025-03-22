resource "aws_db_subnet_group" "this" {
  name       = "${var.environment}-${var.cluster_id}"
  subnet_ids = var.private_subnets
  tags       = var.tags
}

resource "aws_rds_cluster" "this" {
  cluster_identifier      = "${var.environment}-${var.cluster_id}-cluster"
  engine                  = "aurora-postgresql"
  engine_mode             = "provisioned"
  engine_version          = var.engine_version

  database_name           = var.db_name
  db_subnet_group_name    = aws_db_subnet_group.this.name
  skip_final_snapshot     = true

  snapshot_identifier     = var.snapshot_identifier
  tags                    = var.tags
}

resource "aws_rds_cluster_instance" "this" {
  count              = var.instance_count
  identifier         = "${var.environment}-${var.cluster_id}-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = var.db_instance_class
  engine             = aws_rds_cluster.this.engine
  publicly_accessible = false
  tags                = var.tags
}
