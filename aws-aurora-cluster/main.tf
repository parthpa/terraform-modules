resource "aws_db_subnet_group" "aurora" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.private_subnets
  tags = {
    Name = "${var.db_name}-subnet-group"
  }
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "${var.db_name}-cluster"
  engine                  = "aurora-postgresql"
  engine_mode             = "provisioned"
  master_username         = var.db_username
  master_password         = var.db_password
  database_name           = var.db_name
  db_subnet_group_name    = aws_db_subnet_group.aurora.name
  skip_final_snapshot     = true

  backup_retention_period = 7
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  count              = 2
  identifier         = "${var.db_name}-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = var.db_instance_class
  engine             = aws_rds_cluster.aurora.engine
  publicly_accessible = false
}
