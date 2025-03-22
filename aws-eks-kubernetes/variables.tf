variable "image_tag" {
    description = "Tag for the container image"
}

variable "ecr_repo_url" {
    description = "ECR Repo URL"
}

variable "cron_replica_count" {
    description = "Number of Cron Containers. Set this to zero to turn off cron in EKS"
}

variable "env_vars" {
  description = "Environment variables for Kubernetes deployment"
  type        = list(object({
    name  = string
    value = string
  }))
}

variable "aws_eks_worker_role_arn" {
    description = "AWS EKS Worker Role Arn"
}

variable "aws_eks_cluster_ca_certificate" {
    description = "CA Cert for Cluster authentication"
}

variable "aws_eks_cluster_token" {
   description = "Token for Cluster authentication" 
}

variable "aws_eks_cluster_endpoint" {
   description = "Endpoint for EKS Cluster" 
}

variable "namespace" {
    description = "Kubernetes namespace"
}

variable "environment" {
    description = "Deployment environment"
}

variable "cpu_request" {
    description = "Requested CPU"
}

variable "memory_request" {
    description = "Requested Memory"
}

variable "tls_cert_domain_name" {
    description = "Domain Name of TLS Cert to use for Frontend ELB"
}

variable "eks_cluster_id" {
    description = "EKS Cluster ID"
}

variable "aws_region" {
    description = "Region where EKS infra is deployed"
}

variable "enable_cloudwatch_logs" {
    description = "Set this variable to enable cloudwatch logs. Disabled by default"
    default = false
}
