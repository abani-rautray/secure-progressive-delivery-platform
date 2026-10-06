# ==========================================

# App Bucket

# ==========================================

output "app_bucket_name" {
value = aws_s3_bucket.app.bucket
}

output "app_bucket_arn" {
value = aws_s3_bucket.app.arn
}

# ==========================================

# Loki Bucket

# ==========================================

output "loki_bucket_name" {
value = aws_s3_bucket.loki.bucket
}

output "loki_bucket_arn" {
value = aws_s3_bucket.loki.arn
}

# ==========================================

# Backup Bucket

# ==========================================

output "backup_bucket_name" {
value = aws_s3_bucket.backup.bucket
}

output "backup_bucket_arn" {
value = aws_s3_bucket.backup.arn
}
