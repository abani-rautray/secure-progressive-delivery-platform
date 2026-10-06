# ==========================================

# Terraform Assume Role Policy

# ==========================================

data "aws_iam_policy_document" "terraform_assume_role" {
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

# Terraform IAM Role

# ==========================================

resource "aws_iam_role" "terraform" {
name = "${var.project_name}-${var.environment}-terraform-role"

assume_role_policy = data.aws_iam_policy_document.terraform_assume_role.json

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-terraform-role"
}
)
}

# ==========================================

# Terraform Infrastructure Policy

# ==========================================

resource "aws_iam_policy" "terraform" {
name        = "${var.project_name}-${var.environment}-terraform-policy"
description = "Terraform infrastructure provisioning policy"

policy = jsonencode({
Version = "2012-10-17"

```
Statement = [
  {
    Effect = "Allow"

    Action = [
      "ec2:*",
      "eks:*",
      "iam:*",
      "autoscaling:*",
      "elasticloadbalancing:*",
      "ecr:*",
      "logs:*",
      "cloudwatch:*",
      "events:*",
      "sqs:*",
      "kms:*",
      "ssm:*"
    ]

    Resource = "*"
  },

  {
    Effect = "Allow"

    Action = [
      "s3:*"
    ]

    Resource = [
      "arn:aws:s3:::secure-platform-terraform-state",
      "arn:aws:s3:::secure-platform-terraform-state/*"
    ]
  },

  {
    Effect = "Allow"

    Action = [
      "dynamodb:*"
    ]

    Resource = "arn:aws:dynamodb:*:*:table/secure-platform-terraform-locks"
  }
]
```

})

tags = var.common_tags
}

# ==========================================

# Attach Policy

# ==========================================

resource "aws_iam_role_policy_attachment" "terraform" {
role       = aws_iam_role.terraform.name
policy_arn = aws_iam_policy.terraform.arn
}
