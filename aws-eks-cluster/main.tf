module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "${var.environment}-${var.cluster_name}"
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  enable_irsa = true

  manage_aws_auth_configmap = true
  aws_auth_users            = var.map_users

  eks_managed_node_group_defaults = {
    instance_types = [var.instance_type]

    ami_type = "AL2023_x86_64_STANDARD"

    vpc_security_group_ids = var.additional_security_group_ids

    iam_role_additional_policies = {
      fluentbit = aws_iam_policy.fluentbit_cloudwatch_access.arn
      cwagent   = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    }
  }

  eks_managed_node_groups = {
    main = {
      name         = "${var.environment}-${substr(var.cluster_name, 0, 10)}-ng"
      desired_size = var.worker_count
      min_size     = var.worker_count
      max_size     = var.worker_count
    }
  }

  tags = var.tags
}

module "lb_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version   = "5.41.0"

  role_name = "${var.environment}_${var.cluster_name}_eks_lb"
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}

resource "helm_release" "lb" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  version    = "1.7.2"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  depends_on = [
    kubernetes_service_account.service-account
  ]

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "image.repository"
    value = var.controller_image_repo
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "clusterName"
    value = "${var.environment}-${var.cluster_name}"
  }
}

resource "kubernetes_service_account" "service-account" {
  metadata {
    name = "aws-load-balancer-controller"
    namespace = "kube-system"
    labels = {
        "app.kubernetes.io/name"= "aws-load-balancer-controller"
        "app.kubernetes.io/component"= "controller"
    }
    annotations = {
      "eks.amazonaws.com/role-arn" = module.lb_role.iam_role_arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
    }
  }
}

data "aws_eks_cluster" "cluster" {
    name = module.eks.cluster_name
    depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_name
    depends_on = [module.eks]
}

resource "aws_iam_policy" "fluentbit_cloudwatch_access" {
  name   = "${var.environment}_${var.cluster_name}-fluentbit-cloudwatch-access"
  path   = "/"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData",
                "ec2:DescribeVolumes",
                "ec2:DescribeTags",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams",
                "logs:DescribeLogGroups",
                "logs:CreateLogStream",
                "logs:CreateLogGroup",
                "logs:PutRetentionPolicy"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
