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

# Networking

# ==========================================

variable "public_subnet_ids" {
type = list(string)
}

variable "alb_security_group_id" {
type = string
}

# ==========================================

# TLS

# ==========================================

variable "certificate_arn" {
type    = string
default = ""
}

# ==========================================

# Tags

# ==========================================

variable "common_tags" {
type = map(string)

default = {}
}
