# ==========================================

# GitHub OIDC Provider

# ==========================================

resource "aws_iam_openid_connect_provider" "github" {
url = "https://token.actions.githubusercontent.com"

client_id_list = [
"sts.amazonaws.com"
]

thumbprint_list = [
"6938fd4d98bab03faadb97b34396831e3780aea1"
]

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-github-oidc"
}
)
}

# ==========================================

# GitHub Actions Assume Role Policy

# ==========================================

data "aws_iam_policy_document" "github_assume_role" {
statement {
effect = "Allow"

```
actions = [
  "sts:AssumeRoleWithWebIdentity"
]

principals {
  type = "Federated"

  identifiers = [
    aws_iam_openid_connect_provider.github.arn
  ]
}

condition {
  test     = "StringEquals"
  variable = "token.actions.githubusercontent.com:aud"

  values = [
    "sts.amazonaws.com"
  ]
}

condition {
  test     = "StringLike"
  variable = "token.actions.githubusercontent.com:sub"

  values = [
    "repo:${var.github_repository}:*"
  ]
}
```

}
}

# ==========================================

# GitHub Actions IAM Role

# ==========================================

resource "aws_iam_role" "github_actions" {
name = "${var.project_name}-${var.environment}-github-actions-role"

assume_role_policy = data.aws_iam_policy_document.github_assume_role.json

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-github-actions-role"
}
)
}

# ==========================================

# GitHub Actions Policy

# ==========================================

resource "aws_iam_policy" "github_actions" {
name        = "${var.project_name}-${var.environment}-github-actions-policy"
description = "Policy for GitHub Actions CI/CD"

policy = jsonencode({
Version = "2012-10-17"

```
Statement = [
  {
    Effect = "Allow"

    Action = [
      "ecr:*",
      "eks:*",
      "ec2:Describe*",
      "iam:PassRole",
      "cloudformation:*",
      "ssm:GetParameter"
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

resource "aws_iam_role_policy_attachment" "github_actions" {
role       = aws_iam_role.github_actions.name
policy_arn = aws_iam_policy.github_actions.arn
}
