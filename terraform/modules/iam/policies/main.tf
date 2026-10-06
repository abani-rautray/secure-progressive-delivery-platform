# ==========================================

# Karpenter Controller Policy

# ==========================================

resource "aws_iam_policy" "karpenter" {
name        = "${var.project_name}-${var.environment}-karpenter-policy"
description = "Least privilege policy for Karpenter"

policy = jsonencode({
Version = "2012-10-17"

```
Statement = [
  {
    Effect = "Allow"

    Action = [
      "ec2:RunInstances",
      "ec2:TerminateInstances",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeLaunchTemplates",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeSpotPriceHistory",
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "pricing:GetProducts",
      "ssm:GetParameter"
    ]

    Resource = "*"
  },

  {
    Effect = "Allow"

    Action = [
      "iam:PassRole"
    ]

    Resource = var.karpenter_node_role_arn
  }
]
```

})

tags = var.common_tags
}

# ==========================================

# AWS Load Balancer Controller Policy

# ==========================================

resource "aws_iam_policy" "albc" {
name        = "${var.project_name}-${var.environment}-albc-policy"
description = "Least privilege policy for ALBC"

policy = jsonencode({
Version = "2012-10-17"

```
Statement = [
  {
    Effect = "Allow"

    Action = [
      "elasticloadbalancing:*",
      "ec2:Describe*",
      "ec2:CreateSecurityGroup",
      "ec2:CreateTags",
      "ec2:AuthorizeSecurityGroupIngress",
      "iam:CreateServiceLinkedRole",
      "cognito-idp:DescribeUserPoolClient",
      "wafv2:GetWebACL",
      "wafv2:AssociateWebACL",
      "shield:GetSubscriptionState"
    ]

    Resource = "*"
  }
]
```

})

tags = var.common_tags
}

# ==========================================

# Fluent Bit CloudWatch Policy

# ==========================================

resource "aws_iam_policy" "fluentbit" {
name        = "${var.project_name}-${var.environment}-fluentbit-policy"
description = "Policy for Fluent Bit logging"

policy = jsonencode({
Version = "2012-10-17"

```
Statement = [
  {
    Effect = "Allow"

    Action = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    Resource = "*"
  }
]
```

})

tags = var.common_tags
}

# ==========================================

# ECR Read Only Policy

# ==========================================

resource "aws_iam_policy" "ecr_readonly" {
name        = "${var.project_name}-${var.environment}-ecr-readonly-policy"
description = "Read-only ECR access"

policy = jsonencode({
Version = "2012-10-17"

```
Statement = [
  {
    Effect = "Allow"

    Action = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability"
    ]

    Resource = "*"
  }
]
```

})

tags = var.common_tags
}
