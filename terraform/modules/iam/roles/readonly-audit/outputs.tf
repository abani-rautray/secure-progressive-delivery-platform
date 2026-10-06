# ==========================================

# Readonly Audit Outputs

# ==========================================

output "readonly_audit_role_arn" {
value = aws_iam_role.readonly_audit.arn
}

output "readonly_audit_role_name" {
value = aws_iam_role.readonly_audit.name
}
