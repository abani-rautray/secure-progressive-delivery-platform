# ==========================================

# Security Group

# ==========================================

output "vpce_security_group_id" {
value = aws_security_group.vpce.id
}

# ==========================================

# S3 Endpoint

# ==========================================

output "s3_endpoint_id" {
value = aws_vpc_endpoint.s3.id
}

# ==========================================

# ECR API Endpoint

# ==========================================

output "ecr_api_endpoint_id" {
value = aws_vpc_endpoint.ecr_api.id
}

# ==========================================

# ECR Docker Endpoint

# ==========================================

output "ecr_dkr_endpoint_id" {
value = aws_vpc_endpoint.ecr_dkr.id
}

# ==========================================

# STS Endpoint

# ==========================================

output "sts_endpoint_id" {
value = aws_vpc_endpoint.sts.id
}

# ==========================================

# CloudWatch Logs Endpoint

# ==========================================

output "logs_endpoint_id" {
value = aws_vpc_endpoint.logs.id
}
