# ==========================================

# Cluster

# ==========================================

variable "cluster_name" {
type = string
}

variable "kubernetes_version" {
type = string
}

# ==========================================

# Networking

# ==========================================

variable "vpc_id" {
type = string
}

variable "private_subnet_ids" {
type = list(string)
}

variable "cluster_security_group_id" {
type = string
}

# ==========================================

# Tags

# ==========================================

variable "common_tags" {
type = map(string)

default = {}
}
