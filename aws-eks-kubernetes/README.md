<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.observability-addon](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [kubernetes_deployment.cron](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_deployment.deployment](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_ingress_v1.ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/ingress_v1) | resource |
| [kubernetes_namespace.namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_service.service](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_eks_cluster_ca_certificate"></a> [aws\_eks\_cluster\_ca\_certificate](#input\_aws\_eks\_cluster\_ca\_certificate) | CA Cert for Cluster authentication | `any` | n/a | yes |
| <a name="input_aws_eks_cluster_endpoint"></a> [aws\_eks\_cluster\_endpoint](#input\_aws\_eks\_cluster\_endpoint) | Endpoint for EKS Cluster | `any` | n/a | yes |
| <a name="input_aws_eks_cluster_token"></a> [aws\_eks\_cluster\_token](#input\_aws\_eks\_cluster\_token) | Token for Cluster authentication | `any` | n/a | yes |
| <a name="input_aws_eks_worker_role_arn"></a> [aws\_eks\_worker\_role\_arn](#input\_aws\_eks\_worker\_role\_arn) | AWS EKS Worker Role Arn | `any` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region where EKS infra is deployed | `any` | n/a | yes |
| <a name="input_cpu_request"></a> [cpu\_request](#input\_cpu\_request) | Requested CPU | `any` | n/a | yes |
| <a name="input_cron_replica_count"></a> [cron\_replica\_count](#input\_cron\_replica\_count) | Number of Cron Containers. Set this to zero to turn off cron in EKS | `any` | n/a | yes |
| <a name="input_ecr_repo_url"></a> [ecr\_repo\_url](#input\_ecr\_repo\_url) | ECR Repo URL | `any` | n/a | yes |
| <a name="input_eks_cluster_id"></a> [eks\_cluster\_id](#input\_eks\_cluster\_id) | EKS Cluster ID | `any` | n/a | yes |
| <a name="input_enable_cloudwatch_logs"></a> [enable\_cloudwatch\_logs](#input\_enable\_cloudwatch\_logs) | Set this variable to enable cloudwatch logs. Disabled by default | `bool` | `false` | no |
| <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars) | Environment variables for Kubernetes deployment | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment | `any` | n/a | yes |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | Tag for the container image | `any` | n/a | yes |
| <a name="input_memory_request"></a> [memory\_request](#input\_memory\_request) | Requested Memory | `any` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace | `any` | n/a | yes |
| <a name="input_tls_cert_domain_name"></a> [tls\_cert\_domain\_name](#input\_tls\_cert\_domain\_name) | Domain Name of TLS Cert to use for Frontend ELB | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->