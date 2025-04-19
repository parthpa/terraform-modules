output "new_primary_endpoint" {
  description = "Primary endpoint of the fresh Redis cluster"
  value       = aws_elasticache_replication_group.vpc2.primary_endpoint_address
}
