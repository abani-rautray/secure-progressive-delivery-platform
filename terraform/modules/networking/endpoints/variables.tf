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

# AWS

# ==========================================

variable "aws_region" {
type = string
}

# ==========================================

# Networking

# ==========================================

variable "vpc_id" {
type = string
}

variable "vpc_cidr" {
type = string
}

variable "private_subnet_ids" {
type = list(string)
}

variable "private_route_table_ids" {
type = list(string)
}

# ==========================================

# Tags

# ==========================================

variable "common_tags" {
type = map(string)

default = {}
}
