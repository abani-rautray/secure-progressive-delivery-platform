terraform {
required_version = ">= 1.5.0"

required_providers {
aws = {
source  = "hashicorp/aws"
version = "~> 5.0"
}

```
kubernetes = {
  source  = "hashicorp/kubernetes"
  version = "~> 2.25"
}

helm = {
  source  = "hashicorp/helm"
  version = "~> 2.11"
}
```

}
}

# ==========================================
# AWS Provider

provider "aws" {
region = var.aws_region

default_tags {
tags = {
Environment = var.environment
Project     = var.project_name
ManagedBy   = "Terraform"
}
}
}

# ==========================================
# Networking

module "vpc" {
source = "../../modules/networking/vpc"

project_name         = var.project_name
environment          = var.environment
vpc_cidr             = var.vpc_cidr
availability_zones   = var.availability_zones

public_subnet_cidrs  = var.public_subnet_cidrs
private_subnet_cidrs = var.private_subnet_cidrs
}

# ==========================================
# Security-groups

module "security_groups" {
source = "../../modules/networking/security-groups"

project_name = var.project_name
environment  = var.environment

cluster_name = var.cluster_name
vpc_id        = module.vpc.vpc_id

common_tags = var.common_tags
}



# ==========================================
# EKS Cluster

module "eks" {
source = "../../modules/eks/cluster"

cluster_name       = var.cluster_name
kubernetes_version = var.kubernetes_version

vpc_id             = module.vpc.vpc_id
private_subnet_ids = module.vpc.private_subnet_ids

cluster_security_group_id = module.security_groups.eks_cluster_security_group_id

common_tags        = var.common_tags
environment        = var.environment
}


# ==========================================
# EKS NODE Groups

module "nodegroups" {
source = "../../modules/eks/nodegroups"

cluster_name = module.eks.cluster_name

private_subnet_ids = module.vpc.private_subnet_ids

desired_size = var.desired_size
min_size     = var.min_size
max_size     = var.max_size

instance_types = var.node_instance_types

capacity_type = "ON_DEMAND"

common_tags = var.common_tags
}

# ==========================================
# OIDC Provider

module "oidc" {
source = "../../modules/eks/oidc"

cluster_name = module.eks.cluster_name

common_tags = var.common_tags
}

# ==========================================

# Karpenter Node IAM Role


module "karpenter_node_role" {
source = "../../modules/iam/karpenter-node-role"

cluster_name = module.eks.cluster_name

common_tags = var.common_tags
}

# ==========================================

# Custom IAM Policies

# ==========================================

module "iam_policies" {
source = "../../modules/iam/policies"

project_name = var.project_name
environment  = var.environment

karpenter_node_role_arn = module.karpenter_node_role.karpenter_node_role_arn

common_tags = var.common_tags
}


# ==========================================

# IRSA

# ==========================================

module "irsa" {
source = "../../modules/iam/irsa"

cluster_name      = module.eks.cluster_name
oidc_provider_arn = module.oidc.oidc_provider_arn

irsa_roles = {
albc = {
namespace       = "kube-system"
service_account = "aws-load-balancer-controller"

```
  policy_arn = module.iam_policies.albc_policy_arn
}

karpenter = {
  namespace       = "karpenter"
  service_account = "karpenter"

  policy_arn = module.iam_policies.karpenter_policy_arn
}

fluentbit = {
  namespace       = "logging"
  service_account = "fluent-bit"

  policy_arn = module.iam_policies.fluentbit_policy_arn
}

ebs_csi = {
  namespace       = "kube-system"
  service_account = "ebs-csi-controller-sa"

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}
```

}

common_tags = var.common_tags
}



# ==========================================
# Karpenter


module "karpenter" {
source = "../../modules/karpenter/interruption-handling"

cluster_name = module.eks.cluster_name

karpenter_irsa_role_arn = module.irsa.irsa_role_arns["karpenter"]

common_tags = var.common_tags
}


# ==========================================
# AWS Load Balancer Controller


module "albc" {
source = "../../modules/load-balancing/albc"

cluster_name = module.eks.cluster_name
vpc_id       = module.vpc.vpc_id
}

# ==========================================
# ECR


module "ecr" {
source = "../../modules/storage/ecr"

project_name = var.project_name
environment  = var.environment
}

# ==========================================
# S3


module "s3" {
source = "../../modules/storage/s3"

project_name = var.project_name
environment  = var.environment
}

# ==========================================
# Monitoring


module "monitoring" {
source = "../../modules/observability/monitoring"

cluster_name = module.eks.cluster_name
}

# ==========================================
# LOGGING


module "logging" {
source = "../../modules/observability/logging"

aws_region = var.aws_region

loki_bucket_name = module.s3.loki_bucket_name

fluentbit_irsa_role_arn = module.irsa.irsa_role_arns["fluentbit"]

common_tags = var.common_tags
}


# ==========================================
# EKS ADDONS
module "eks_addons" {
source = "../../modules/eks/addons"

cluster_name = module.eks.cluster_name

common_tags = var.common_tags
}

# ===========================================
# GITHUB ACTIONS Role

module "github_actions_role" {
source = "../../modules/iam/roles/github-actions"

project_name = var.project_name
environment  = var.environment

github_repository = "abani-rautray/terraform-eks-karpenter-gitops"

common_tags = var.common_tags
}

# =============================================
# TERRAFORM Role

module "terraform_role" {
source = "../../modules/iam/roles/terraform-role"

project_name = var.project_name
environment  = var.environment

trusted_role_arns = [
module.github_actions_role.github_actions_role_arn
]

common_tags = var.common_tags
}

# ==============================================
# READ ONLY AUDIT ROLE

module "readonly_audit_role" {
source = "../../modules/iam/roles/readonly-audit"

project_name = var.project_name
environment  = var.environment

trusted_role_arns = [
module.github_actions_role.github_actions_role_arn
]

common_tags = var.common_tags
}

# ================================================
# ALBC

module "albc" {
source = "../../modules/load-balancing/albc"

cluster_name = module.eks.cluster_name

aws_region = var.aws_region
vpc_id     = module.vpc.vpc_id

albc_irsa_role_arn = module.irsa.irsa_role_arns["albc"]

common_tags = var.common_tags
}


# =================================================
# SHARED ALB

module "shared_alb" {
source = "../../modules/load-balancing/shared-alb"

project_name = var.project_name
environment  = var.environment

public_subnet_ids = module.vpc.public_subnet_ids

alb_security_group_id = module.security_groups.alb_security_group_id

common_tags = var.common_tags
}

# ==================================================
# INGRESS GROUPS

module "ingress_groups" {
source = "../../modules/load-balancing/ingress-groups"

project_name = var.project_name
environment  = var.environment

vpc_id = module.vpc.vpc_id

http_listener_arn = module.shared_alb.http_listener_arn

common_tags = var.common_tags
}


# ==================================================
# KARPENTER SQS

module "karpenter_sqs" {
source = "../../modules/karpenter/sqs"

cluster_name = module.eks.cluster_name

common_tags = var.common_tags
}

# ==================================================
# KARPENTER EVENTBRIDGE

module "karpenter_eventbridge" {
source = "../../modules/karpenter/eventbridge"

cluster_name = module.eks.cluster_name

sqs_queue_arn = module.karpenter_sqs.queue_arn
sqs_queue_url = module.karpenter_sqs.queue_url

common_tags = var.common_tags
}

# ==================================================
# MONITORING

module "monitoring" {
source = "../../modules/observability/monitoring"

cluster_name = module.eks.cluster_name

common_tags = var.common_tags
}

# ==================================================
#

# ==================================================
#

# ==================================================
#

# ==================================================
#
