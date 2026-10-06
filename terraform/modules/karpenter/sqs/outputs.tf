# ==========================================

# Main Queue

# ==========================================

output "queue_name" {
value = aws_sqs_queue.karpenter.name
}

output "queue_url" {
value = aws_sqs_queue.karpenter.url
}

output "queue_arn" {
value = aws_sqs_queue.karpenter.arn
}

# ==========================================

# Dead Letter Queue

# ==========================================

output "dlq_arn" {
value = aws_sqs_queue.karpenter_dlq.arn
}
