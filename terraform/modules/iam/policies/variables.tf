# ==========================================

# Project

# ==========================================

variable "project_name" {
type = string
}

variable "environment" {
type = string
}

# ==========================================

# Karpenter

# ==========================================

variable "karpenter_node_role_arn" {
type = string
}

# ==========================================

# Tags

# ==========================================

variable "common_tags" {
type = map(string)

default = {}
}
