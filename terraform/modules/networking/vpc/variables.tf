# ==========================================

# Project

# ==========================================

variable "project_name" {
description = "Project name"
type        = string
}

variable "environment" {
description = "Deployment environment"
type        = string
}

# ==========================================

# Networking

# ==========================================

variable "vpc_cidr" {
description = "VPC CIDR block"
type        = string
}

variable "availability_zones" {
description = "Availability zones"

type = list(string)
}

variable "public_subnet_cidrs" {
description = "Public subnet CIDRs"

type = list(string)
}

variable "private_subnet_cidrs" {
description = "Private subnet CIDRs"

type = list(string)
}

# ==========================================

# EKS / Karpenter

# ==========================================

variable "cluster_name" {
description = "EKS cluster name"
type        = string
}

# ==========================================

# Common Tags

# ==========================================

variable "common_tags" {
description = "Common tags"

type = map(string)

default = {}
}
