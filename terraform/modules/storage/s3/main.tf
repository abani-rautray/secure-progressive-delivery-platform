# ==========================================

# Application Bucket

# ==========================================

resource "aws_s3_bucket" "app" {
bucket = "${var.project_name}-${var.environment}-app-storage"

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-app-storage"
}
)
}

# ==========================================

# Loki Logs Bucket

# ==========================================

resource "aws_s3_bucket" "loki" {
bucket = "${var.project_name}-${var.environment}-loki-logs"

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-loki-logs"
}
)
}

# ==========================================

# Backup Bucket

# ==========================================

resource "aws_s3_bucket" "backup" {
bucket = "${var.project_name}-${var.environment}-backup"

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-backup"
}
)
}

# ==========================================

# Versioning

# ==========================================

resource "aws_s3_bucket_versioning" "app" {
bucket = aws_s3_bucket.app.id

versioning_configuration {
status = "Enabled"
}
}

resource "aws_s3_bucket_versioning" "loki" {
bucket = aws_s3_bucket.loki.id

versioning_configuration {
status = "Enabled"
}
}

resource "aws_s3_bucket_versioning" "backup" {
bucket = aws_s3_bucket.backup.id

versioning_configuration {
status = "Enabled"
}
}

# ==========================================

# Encryption

# ==========================================

resource "aws_s3_bucket_server_side_encryption_configuration" "app" {
bucket = aws_s3_bucket.app.id

rule {
apply_server_side_encryption_by_default {
sse_algorithm = "AES256"
}
}
}

resource "aws_s3_bucket_server_side_encryption_configuration" "loki" {
bucket = aws_s3_bucket.loki.id

rule {
apply_server_side_encryption_by_default {
sse_algorithm = "AES256"
}
}
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backup" {
bucket = aws_s3_bucket.backup.id

rule {
apply_server_side_encryption_by_default {
sse_algorithm = "AES256"
}
}
}

# ==========================================

# Public Access Block

# ==========================================

resource "aws_s3_bucket_public_access_block" "app" {
bucket = aws_s3_bucket.app.id

block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "loki" {
bucket = aws_s3_bucket.loki.id

block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "backup" {
bucket = aws_s3_bucket.backup.id

block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true
}

# ==========================================

# Lifecycle Rules

# ==========================================

resource "aws_s3_bucket_lifecycle_configuration" "backup" {
bucket = aws_s3_bucket.backup.id

rule {
id     = "backup-retention"
status = "Enabled"

```
expiration {
  days = 90
}

noncurrent_version_expiration {
  noncurrent_days = 30
}
```

}
}

# ==========================================

# Enforce HTTPS Only

# ==========================================

data "aws_iam_policy_document" "https_only" {
statement {
sid    = "DenyInsecureTransport"
effect = "Deny"

```
principals {
  type        = "*"
  identifiers = ["*"]
}

actions = [
  "s3:*"
]

resources = [
  aws_s3_bucket.app.arn,
  "${aws_s3_bucket.app.arn}/*",
  aws_s3_bucket.loki.arn,
  "${aws_s3_bucket.loki.arn}/*",
  aws_s3_bucket.backup.arn,
  "${aws_s3_bucket.backup.arn}/*"
]

condition {
  test     = "Bool"
  variable = "aws:SecureTransport"

  values = [
    "false"
  ]
}
```

}
}

resource "aws_s3_bucket_policy" "https_only" {
bucket = aws_s3_bucket.app.id

policy = data.aws_iam_policy_document.https_only.json
}
