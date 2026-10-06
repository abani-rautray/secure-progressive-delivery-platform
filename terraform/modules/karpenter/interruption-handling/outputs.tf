# ==========================================

# Queue Outputs

# ==========================================

output "queue_name" {
value = module.sqs.queue_name
}

output "queue_arn" {
value = module.sqs.queue_arn
}

# ==========================================

# Helm Release

# ==========================================

output "helm_release_name" {
value = helm_release.karpenter.name
}
