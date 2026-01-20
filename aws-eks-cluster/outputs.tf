output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "worker_security_group_id" {
  description = "Security group ids attached to the workers."
  value       = module.eks.node_security_group_id
}

output "aws_eks_cluster_endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}

output "aws_eks_cluster_token" {
  value = data.aws_eks_cluster_auth.cluster.token
}

output "aws_eks_cluster_ca_certificate" {
  value = data.aws_eks_cluster.cluster.certificate_authority.0.data
}

output "worker_iam_role_arn" {
  description = "worker iam role arn"
  value = module.eks.self_managed_node_groups.iam_role_arn
}
