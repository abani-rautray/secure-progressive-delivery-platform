# Networking Outputs
#------------------------------------

output "vpc_id" {
description = "VPC ID"

value = module.vpc.vpc_id
}

output "public_subnet_ids" {
description = "Public subnet IDs"

value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
description = "Private subnet IDs"

value = module.vpc.private_subnet_ids
}


# EKS Outputs
#----------------------------------------

output "cluster_name" {
description = "EKS cluster name"

value = module.eks.cluster_name
}

output "cluster_endpoint" {
description = "EKS cluster endpoint"

value = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
description = "Cluster security group ID"

value = module.eks.cluster_security_group_id
}

output "cluster_oidc_issuer_url" {
description = "OIDC issuer URL"

value = module.eks.cluster_oidc_issuer_url
}


# IAM / IRSA Outputs
#-----------------------------------------

output "oidc_provider_arn" {
description = "OIDC provider ARN"

value = module.oidc.oidc_provider_arn
}


# ECR Outputs
#---------------------------


output "frontend_ecr_repository_url" {
value = module.ecr.frontend_repository_url
}

output "backend_ecr_repository_url" {
value = module.ecr.backend_repository_url
}

output "canary_ecr_repository_url" {
value = module.ecr.canary_repository_url
}


output "ecr_repository_name" {
description = "ECR repository name"

value = module.ecr.repository_name
}

# S3 Outputs
#-------------------------------------

output "s3_bucket_name" {
description = "Application S3 bucket"

value = module.s3.bucket_name
}

# Load Balancer Outputs

output "alb_security_group_id" {
description = "ALB security group ID"

value = module.albc.alb_security_group_id
}

# Observability Outputs
#-------------------------------------------

output "monitoring_namespace" {
description = "Monitoring namespace"

value = module.monitoring.namespace
}

output "logging_namespace" {
description = "Logging namespace"

value = module.logging.namespace
}
