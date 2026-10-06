# ==========================================

# Karpenter Interruption Queue

# ==========================================

resource "aws_sqs_queue" "karpenter" {
name = "${var.cluster_name}-karpenter-interruptions"

message_retention_seconds = 300

visibility_timeout_seconds = 30

sqs_managed_sse_enabled = true

tags = merge(
var.common_tags,
{
Name = "${var.cluster_name}-karpenter-sqs"
}
)
}

# ==========================================

# Dead Letter Queue

# ==========================================

resource "aws_sqs_queue" "karpenter_dlq" {
name = "${var.cluster_name}-karpenter-dlq"

message_retention_seconds = 1209600

sqs_managed_sse_enabled = true

tags = merge(
var.common_tags,
{
Name = "${var.cluster_name}-karpenter-dlq"
}
)
}

# ==========================================

# Redrive Policy

# ==========================================

resource "aws_sqs_queue_redrive_policy" "karpenter" {
queue_url = aws_sqs_queue.karpenter.id

redrive_policy = jsonencode({
deadLetterTargetArn = aws_sqs_queue.karpenter_dlq.arn
maxReceiveCount     = 5
})
}
