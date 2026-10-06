# ==========================================

# EKS Cluster SG

# ==========================================

output "eks_cluster_security_group_id" {
value = aws_security_group.eks_cluster.id
}

# ==========================================

# Worker Nodes SG

# ==========================================

output "worker_nodes_security_group_id" {
value = aws_security_group.worker_nodes.id
}

# ==========================================

# ALB SG

# ==========================================

output "alb_security_group_id" {
value = aws_security_group.alb.id
}
