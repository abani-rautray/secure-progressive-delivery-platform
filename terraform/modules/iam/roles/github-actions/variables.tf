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

# GitHub

# ==========================================

variable "github_repository" {
description = "GitHub repository in owner/repo format"

type = string
}

# ==========================================

# Tags

# ==========================================

variable "common_tags" {
type = map(string)

default = {}
}
