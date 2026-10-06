data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "loki_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    condition {
      test     = "StringEquals"
      variable = "${var.oidc_issuer}:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${var.oidc_issuer}:sub"

      values = [
        "system:serviceaccount:${var.namespace}:${var.service_account_name}"
      ]
    }
  }
}

resource "aws_iam_role" "loki" {
  name = "${var.name_prefix}-loki-irsa"

  assume_role_policy = data.aws_iam_policy_document.loki_assume_role.json

  tags = var.tags
}

data "aws_iam_policy_document" "loki_s3" {
  statement {
    sid    = "LokiS3BucketAccess"
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      var.s3_bucket_arn
    ]
  }

  statement {
    sid    = "LokiS3ObjectAccess"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${var.s3_bucket_arn}/*"
    ]
  }
}

resource "aws_iam_policy" "loki_s3" {
  name = "${var.name_prefix}-loki-s3"

  policy = data.aws_iam_policy_document.loki_s3.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "loki_s3" {
  role       = aws_iam_role.loki.name
  policy_arn = aws_iam_policy.loki_s3.arn
}