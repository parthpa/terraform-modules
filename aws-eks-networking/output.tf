output "vpc_id" {
  value = module.vpc.vpc_id
  description = "ID of the VPC"
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets[*].id
  description = "List of IDs of the public subnets"
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets[*].id
  description = "List of IDs of the private subnets"
}

output "private_route_table_id" {
  value = module.vpc.private_route_table_ids[0] # Access the first private route table ID
  description = "ID of the private route table"
}

output "public_route_table_id" {
  value = module.vpc.public_route_table_ids[0] # Access the first public route table ID
  description = "ID of the public route table"
}

output "nat_gateway_ids" {
  value = module.vpc.nat_gateway_ids
  description = "List of NAT Gateway IDs"
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "private_subnets" {
  value = module.networking.private_subnets
}

output "public_subnets" {
  value = module.networking.public_subnets
}

output "eks_subnets" {
  value = slice(module.networking.private_subnets, 0, length(module.networking.private_subnets) / 2)
}

output "rds_subnets" {
  value = slice(module.networking.private_subnets, length(module.networking.private_subnets) / 2, length(module.networking.private_subnets))
}
