variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
}

variable "subnet_count" {
  description = "Number of subnets to create"
}

variable "subnet_cidr" {
  type        = list(string)
  description = "List of subnet CIDR blocks"
}

variable "security_group_name" {
  description = "Name for the security group"
}

variable "db_subnet_group_create" {
  description = "Whether to create this resource or not?"
  type        = bool
  default     = true
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
  default     = ""
}

variable "db_subnet_group_name_prefix" {
  description = "Determines whether to use `name` as is or create a unique name beginning with `name` as the specified prefix"
  type        = bool
  default     = false
}

variable "db_subnet_group_description" {
  description = "The description of the DB subnet group"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "azs" {
  type    = list(string)
}
