# ==========================================

# Cluster

# ==========================================

variable "cluster_name" {
type = string
}

# ==========================================

# OIDC

# ==========================================

variable "oidc_provider_arn" {
type = string
}

# ==========================================

# IRSA Roles

# ==========================================

variable "irsa_roles" {
description = "IRSA role definitions"

type = map(object({
namespace       = string
service_account = string
policy_arn      = string
}))
}

# ==========================================

# Tags

# ==========================================

variable "common_tags" {
type = map(string)

default = {}
}
