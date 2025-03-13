output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_ids" {
  value = aws_subnet.this[*].id
}

output "db_security_group_id" {
  description = "The db subnet group name"
  value       = aws_security_group.this.id
}

output "db_subnet_group_id" {
  description = "The db subnet group name"
  value       = try(aws_db_subnet_group.this[0].id, "")
}

output "db_subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = try(aws_db_subnet_group.this[0].arn, "")
}
