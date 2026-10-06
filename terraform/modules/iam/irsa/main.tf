# ==========================================

# OIDC Provider Data

# ==========================================

data "aws_iam_openid_connect_provider" "this" {
arn = var.oidc_provider_arn
}

# ==========================================

# Common IRSA Trust Policy

# ==========================================

data "aws_iam_policy_document" "irsa_assume_role" {
for_each = var.irsa_roles

statement {
effect = "Allow"

```
actions = [
  "sts:AssumeRoleWithWebIdentity"
]

principals {
  type = "Federated"

  identifiers = [
    var.oidc_provider_arn
  ]
}

condition {
  test = "StringEquals"

  variable = "${replace(data.aws_iam_openid_connect_provider.this.url, "https://", "")}:sub"

  values = [
    "system:serviceaccount:${each.value.namespace}:${each.value.service_account}"
  ]
}
```

}
}

# ==========================================

# IRSA IAM Roles

# ==========================================

resource "aws_iam_role" "irsa" {
for_each = var.irsa_roles

name = "${var.cluster_name}-${each.key}-irsa-role"

assume_role_policy = data.aws_iam_policy_document.irsa_assume_role[each.key].json

tags = merge(
var.common_tags,
{
Name = "${var.cluster_name}-${each.key}-irsa-role"
}
)
}

# ==========================================

# Policy Attachments

# ==========================================

resource "aws_iam_role_policy_attachment" "irsa" {
for_each = var.irsa_roles

role       = aws_iam_role.irsa[each.key].name
policy_arn = each.value.policy_arn
}
