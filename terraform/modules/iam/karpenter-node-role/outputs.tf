# ==========================================

# IAM Role

# ==========================================

output "karpenter_node_role_arn" {
value = aws_iam_role.karpenter_node.arn
}

output "karpenter_node_role_name" {
value = aws_iam_role.karpenter_node.name
}

# ==========================================

# Instance Profile

# ==========================================

output "instance_profile_name" {
value = aws_iam_instance_profile.karpenter_node.name
}

output "instance_profile_arn" {
value = aws_iam_instance_profile.karpenter_node.arn
}
