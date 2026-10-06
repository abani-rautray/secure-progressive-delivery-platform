# ==========================================

# Karpenter Policy

# ==========================================

output "karpenter_policy_arn" {
value = aws_iam_policy.karpenter.arn
}

# ==========================================

# ALBC Policy

# ==========================================

output "albc_policy_arn" {
value = aws_iam_policy.albc.arn
}

# ==========================================

# Fluent Bit Policy

# ==========================================

output "fluentbit_policy_arn" {
value = aws_iam_policy.fluentbit.arn
}

# ==========================================

# ECR Readonly Policy

# ==========================================

output "ecr_readonly_policy_arn" {
value = aws_iam_policy.ecr_readonly.arn
}
