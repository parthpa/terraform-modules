output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

output "cluster_name" {
  description = "Kubernetes cluster name."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group id attached to the EKS control plane."
  value       = module.eks.cluster_security_group_id
}

output "cluster_primary_security_group_id" {
  description = "Cluster primary security group created by Amazon EKS."
  value       = module.eks.cluster_primary_security_group_id
}

output "worker_security_group_id" {
  description = "Security group id attached to the nodes (shared node SG)."
  value       = module.eks.node_security_group_id
}

output "node_security_group_id" {
  description = "ID of the node shared security group."
  value       = module.eks.node_security_group_id
}

output "kubectl_config" {
  description = "Command to configure kubectl for this cluster"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.region}"
}

output "config_map_aws_auth" {
  description = "Formatted YAML for the aws-auth ConfigMap (legacy)."
  value       = module.eks.aws_auth_configmap_yaml
}

output "aws_eks_cluster_endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}

output "aws_eks_cluster_token" {
  value = data.aws_eks_cluster_auth.cluster.token
}

output "aws_eks_cluster_ca_certificate" {
  value = data.aws_eks_cluster.cluster.certificate_authority[0].data
}

output "worker_iam_role_arn" {
  description = "Worker IAM role ARN (self-managed node group role)."
  value       = try(module.eks.self_managed_node_groups[local.worker_group_key].iam_role_arn, null)
}
