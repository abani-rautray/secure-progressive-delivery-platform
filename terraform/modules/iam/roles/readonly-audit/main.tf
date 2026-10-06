# ==========================================

# Readonly Audit Assume Role Policy

# ==========================================

data "aws_iam_policy_document" "readonly_assume_role" {
statement {
effect = "Allow"

```
actions = [
  "sts:AssumeRole"
]

principals {
  type = "AWS"

  identifiers = var.trusted_role_arns
}
```

}
}

# ==========================================

# Readonly Audit Role

# ==========================================

resource "aws_iam_role" "readonly_audit" {
name = "${var.project_name}-${var.environment}-readonly-audit-role"

assume_role_policy = data.aws_iam_policy_document.readonly_assume_role.json

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-readonly-audit-role"
}
)
}

# ==========================================

# AWS Managed ReadOnlyAccess Policy

# ==========================================

resource "aws_iam_role_policy_attachment" "readonly_access" {
role       = aws_iam_role.readonly_audit.name
policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# ==========================================

# SecurityAudit Policy

# ==========================================

resource "aws_iam_role_policy_attachment" "security_audit" {
role       = aws_iam_role.readonly_audit.name
policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
