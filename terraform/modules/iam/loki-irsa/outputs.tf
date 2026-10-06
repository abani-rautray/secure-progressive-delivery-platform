output "role_arn" {
  description = "IAM role ARN for Loki."
  value       = aws_iam_role.loki.arn
}

output "role_name" {
  description = "IAM role name for Loki."
  value       = aws_iam_role.loki.name
}

output "policy_arn" {
  description = "IAM policy ARN for Loki S3 access."
  value       = aws_iam_policy.loki_s3.arn
}