variable "environment" {
  type = string
  description = "Environment name (e.g., dev, prod)"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  type = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type = list(string)
  description = "List of CIDR blocks for public subnets"
}

variable "private_subnet_cidrs" {
  type = list(string)
  description = "List of CIDR blocks for private subnets"
}

variable "enable_nat_gateway" {
  type = bool
  description = "Enables a NAT Gateway in the public subnets"
  default = true
}

variable "single_nat_gateway" {
  type = bool
  description = "Use a single NAT gateway for cost optimisation"
  default = true
}

variable "enable_vpn_gateway" {
  type = bool
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
  default = false
}

variable "enable_dns_support" {
  type = bool
  description = "Should be true to enable DNS support in the VPC"
  default = true
}

variable "enable_dns_hostnames" {
  type = bool
  description = "Should be true to enable DNS hostnames in the VPC"
  default = true
}

variable "additional_tags" {
  description = "Addditional tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "additional_private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}

variable "additional_public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}
