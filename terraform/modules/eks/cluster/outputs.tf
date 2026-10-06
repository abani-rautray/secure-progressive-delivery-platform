# ==========================================

# Cluster Outputs

# ==========================================

output "cluster_name" {
value = aws_eks_cluster.this.name
}

output "cluster_arn" {
value = aws_eks_cluster.this.arn
}

output "cluster_endpoint" {
value = aws_eks_cluster.this.endpoint
}

output "cluster_version" {
value = aws_eks_cluster.this.version
}

# ==========================================

# Cluster Security

# ==========================================

output "cluster_security_group_id" {
value = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

output "cluster_oidc_issuer_url" {
value = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

# ==========================================

# IAM Outputs

# ==========================================

output "cluster_role_arn" {
value = aws_iam_role.eks_cluster_role.arn
}

# ==========================================

# Encryption

# ==========================================

output "kms_key_arn" {
value = aws_kms_key.eks.arn
}
