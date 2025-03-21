variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "cluster_id" {
  description = "Prefix for the cluster identifier"
  type        = string
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnets" {
  description = "Private subnet IDs for Aurora"
  type        = list(string)
}

variable "engine_version" {
  description = "Aurora engine version"
  type        = string
}
variable "db_username" {
  description = "Database master username"
  type        = string
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "db_instance_class" {
  description = "Instance class for Aurora instances"
  type        = string
}

variable "tags" {
  description = "tags to apply to rds aurora cluster"
  type        = map(string)
  default     = {}
}
