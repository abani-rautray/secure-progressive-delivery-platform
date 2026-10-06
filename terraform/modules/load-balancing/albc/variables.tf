# ==========================================

# Cluster

# ==========================================

variable "cluster_name" {
type = string
}

# ==========================================

# AWS

# ==========================================

variable "aws_region" {
type = string
}

variable "vpc_id" {
type = string
}

# ==========================================

# IRSA

# ==========================================

variable "albc_irsa_role_arn" {
type = string
}

# ==========================================

# Tags

# ==========================================

variable "common_tags" {
type = map(string)

default = {}
}
