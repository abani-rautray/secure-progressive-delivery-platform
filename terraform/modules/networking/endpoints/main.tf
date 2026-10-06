# ==========================================

# Security Group For Interface Endpoints

# ==========================================

resource "aws_security_group" "vpce" {
name        = "${var.project_name}-${var.environment}-vpce-sg"
description = "Security group for VPC endpoints"
vpc_id      = var.vpc_id

ingress {
description = "HTTPS from VPC"

```
from_port = 443
to_port   = 443
protocol  = "tcp"

cidr_blocks = [var.vpc_cidr]
```

}

egress {
from_port = 0
to_port   = 0
protocol  = "-1"

```
cidr_blocks = ["0.0.0.0/0"]
```

}

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-${var.environment}-vpce-sg"
}
)
}

# ==========================================

# S3 Gateway Endpoint

# ==========================================

resource "aws_vpc_endpoint" "s3" {
vpc_id            = var.vpc_id
service_name      = "com.amazonaws.${var.aws_region}.s3"
vpc_endpoint_type = "Gateway"

route_table_ids = var.private_route_table_ids

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-${var.environment}-s3-endpoint"
}
)
}

# ==========================================

# ECR API Endpoint

# ==========================================

resource "aws_vpc_endpoint" "ecr_api" {
vpc_id              = var.vpc_id
service_name        = "com.amazonaws.${var.aws_region}.ecr.api"
vpc_endpoint_type   = "Interface"

subnet_ids          = var.private_subnet_ids
security_group_ids  = [aws_security_group.vpce.id]

private_dns_enabled = true

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-${var.environment}-ecr-api-endpoint"
}
)
}

# ==========================================

# ECR Docker Endpoint

# ==========================================

resource "aws_vpc_endpoint" "ecr_dkr" {
vpc_id              = var.vpc_id
service_name        = "com.amazonaws.${var.aws_region}.ecr.dkr"
vpc_endpoint_type   = "Interface"

subnet_ids          = var.private_subnet_ids
security_group_ids  = [aws_security_group.vpce.id]

private_dns_enabled = true

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-${var.environment}-ecr-dkr-endpoint"
}
)
}

# ==========================================

# STS Endpoint

# ==========================================

resource "aws_vpc_endpoint" "sts" {
vpc_id              = var.vpc_id
service_name        = "com.amazonaws.${var.aws_region}.sts"
vpc_endpoint_type   = "Interface"

subnet_ids          = var.private_subnet_ids
security_group_ids  = [aws_security_group.vpce.id]

private_dns_enabled = true

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-${var.environment}-sts-endpoint"
}
)
}

# ==========================================

# CloudWatch Logs Endpoint

# ==========================================

resource "aws_vpc_endpoint" "logs" {
vpc_id              = var.vpc_id
service_name        = "com.amazonaws.${var.aws_region}.logs"
vpc_endpoint_type   = "Interface"

subnet_ids          = var.private_subnet_ids
security_group_ids  = [aws_security_group.vpce.id]

private_dns_enabled = true

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-${var.environment}-logs-endpoint"
}
)
}
