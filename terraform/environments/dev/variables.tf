# ==========================================

# Global

# ==========================================

variable "project_name" {
description = "Project name"
type        = string

default = "secure-progressive-delivery-platform"
}

variable "environment" {
description = "Deployment environment"
type        = string

default = "dev"
}

variable "aws_region" {
description = "AWS region"
type        = string

default = "ap-south-1"
}

# ==========================================

# Networking

# ==========================================

variable "vpc_cidr" {
description = "VPC CIDR block"
type        = string

default = "10.0.0.0/16"
}

variable "availability_zones" {
description = "Availability zones"

type = list(string)

default = [
"ap-south-1a",
"ap-south-1b"
]
}

variable "public_subnet_cidrs" {
description = "Public subnet CIDRs"

type = list(string)

default = [
"10.0.1.0/24",
"10.0.2.0/24"
]
}

variable "private_subnet_cidrs" {
description = "Private subnet CIDRs"

type = list(string)

default = [
"10.0.11.0/24",
"10.0.12.0/24"
]
}

# ==========================================

# EKS

# ==========================================

variable "cluster_name" {
description = "EKS cluster name"
type        = string

default = "secure-platform-eks"
}

variable "kubernetes_version" {
description = "Kubernetes version"
type        = string

default = "1.30"
}

# ==========================================

# Node Group

# ==========================================

variable "node_instance_types" {
description = "EKS node instance types"

type = list(string)

default = [
"t3.medium"
]
}

variable "desired_size" {
description = "Desired node count"
type        = number

default = 2
}

variable "min_size" {
description = "Minimum node count"
type        = number

default = 1
}

variable "max_size" {
description = "Maximum node count"
type        = number

default = 4
}

# ==========================================

# Karpenter

# ==========================================

variable "karpenter_instance_family" {
description = "Karpenter instance family"
type        = string

default = "t3"
}

variable "karpenter_capacity_type" {
description = "Karpenter capacity type"
type        = string

default = "spot"
}

# ==========================================

# Tags

# ==========================================

variable "common_tags" {
description = "Common tags for all resources"

type = map(string)

default = {
Project     = "secure-progressive-delivery-platform"
Environment = "dev"
ManagedBy   = "Terraform"
Owner       = "platform-team"
}
}
