# ==========================================

# Cluster

# ==========================================

variable "cluster_name" {
type = string
}

# ==========================================

# SQS

# ==========================================

variable "sqs_queue_arn" {
type = string
}

variable "sqs_queue_url" {
type = string
}

# ==========================================

# Tags

# ==========================================

variable "common_tags" {
type = map(string)

default = {}
}
