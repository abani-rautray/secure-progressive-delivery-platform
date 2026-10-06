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

# Trusted Roles

# ==========================================

variable "trusted_role_arns" {
description = "Roles allowed to assume Terraform role"

type = list(string)
}

# ==========================================

# Tags

# ==========================================

variable "common_tags" {
type = map(string)

default = {}
}
