resource "aws_db_subnet_group" "this" {
  name       = "${var.environment}-${var.cluster_id}"
  subnet_ids = var.private_subnets
  # tags       = var.tags
}

resource "aws_rds_cluster" "this" {
  cluster_identifier      = "${var.environment}-${var.cluster_id}-cluster"
  engine                  = "aurora-postgresql"
  engine_mode             = "provisioned"
  master_username         = var.db_username
  master_password         = var.db_password
  database_name           = var.db_name
  db_subnet_group_name    = aws_db_subnet_group.this.name
  skip_final_snapshot     = true

  tags                    = var.tags
}

resource "aws_rds_cluster_instance" "this" {
  count              = 2
  identifier         = "${var.environment}-${var.cluster_id}-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = var.db_instance_class
  engine             = aws_rds_cluster.this.engine
  publicly_accessible = false
  tags                = var.tags
}
