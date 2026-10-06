# ==========================================

# Cluster

# ==========================================

variable "cluster_name" {
type = string
}

# ==========================================

# Networking

# ==========================================

variable "private_subnet_ids" {
type = list(string)
}

# ==========================================

# Node Group Scaling

# ==========================================

variable "desired_size" {
type = number
}

variable "min_size" {
type = number
}

variable "max_size" {
type = number
}

# ==========================================

# Node Configuration

# ==========================================

variable "instance_types" {
type = list(string)
}

variable "capacity_type" {
type    = string
default = "ON_DEMAND"
}

variable "disk_size" {
type    = number
default = 50
}

# ==========================================

# Tags

# ==========================================

variable "common_tags" {
type = map(string)

default = {}
}
