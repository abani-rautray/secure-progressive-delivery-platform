# ==========================================

# Node Group Outputs

# ==========================================

output "node_group_name" {
value = aws_eks_node_group.this.node_group_name
}

output "node_group_arn" {
value = aws_eks_node_group.this.arn
}

output "node_role_arn" {
value = aws_iam_role.nodegroup.arn
}

output "launch_template_id" {
value = aws_launch_template.nodegroup.id
}
