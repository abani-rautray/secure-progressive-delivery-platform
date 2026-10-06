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

# Tags

# ==========================================

variable "common_tags" {
type = map(string)

default = {}
}
