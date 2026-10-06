# ==========================================

# VPC Outputs

# ==========================================

output "vpc_id" {
description = "VPC ID"

value = aws_vpc.this.id
}

output "vpc_cidr_block" {
description = "VPC CIDR block"

value = aws_vpc.this.cidr_block
}

# ==========================================

# Internet Gateway

# ==========================================

output "internet_gateway_id" {
description = "Internet Gateway ID"

value = aws_internet_gateway.this.id
}

# ==========================================

# Public Subnets

# ==========================================

output "public_subnet_ids" {
description = "Public subnet IDs"

value = aws_subnet.public[*].id
}

output "public_subnet_cidrs" {
description = "Public subnet CIDRs"

value = aws_subnet.public[*].cidr_block
}

# ==========================================

# Private Subnets

# ==========================================

output "private_subnet_ids" {
description = "Private subnet IDs"

value = aws_subnet.private[*].id
}

output "private_subnet_cidrs" {
description = "Private subnet CIDRs"

value = aws_subnet.private[*].cidr_block
}

# ==========================================

# NAT Gateway Outputs

# ==========================================

output "nat_gateway_ids" {
description = "NAT Gateway IDs"

value = aws_nat_gateway.this[*].id
}

output "elastic_ip_ids" {
description = "Elastic IP allocation IDs"

value = aws_eip.nat[*].id
}

output "elastic_ip_public_ips" {
description = "Elastic IP public IPs"

value = aws_eip.nat[*].public_ip
}

# ==========================================

# Route Tables

# ==========================================

output "public_route_table_id" {
description = "Public route table ID"

value = aws_route_table.public.id
}

output "private_route_table_ids" {
description = "Private route table IDs"

value = aws_route_table.private[*].id
}
