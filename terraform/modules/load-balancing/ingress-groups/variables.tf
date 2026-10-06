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

variable "vpc_id" {
type = string
}

# ==========================================

# ALB Listener

# ==========================================

variable "http_listener_arn" {
type = string
}

# ==========================================

# Tags

# ==========================================

variable "common_tags" {
type = map(string)

default = {}
}
