# ==========================================

# Cluster

# ==========================================

variable "cluster_name" {
description = "EKS cluster name"
type        = string
}

# ==========================================

# Tags

# ==========================================

variable "common_tags" {
description = "Common tags"

type = map(string)

default = {}
}
