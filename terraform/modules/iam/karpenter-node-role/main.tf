# ==========================================

# Karpenter Node IAM Role

# ==========================================

resource "aws_iam_role" "karpenter_node" {
name = "${var.cluster_name}-karpenter-node-role"

assume_role_policy = jsonencode({
Version = "2012-10-17"

```
Statement = [
  {
    Effect = "Allow"

    Principal = {
      Service = "ec2.amazonaws.com"
    }

    Action = "sts:AssumeRole"
  }
]
```

})

tags = merge(
var.common_tags,
{
Name = "${var.cluster_name}-karpenter-node-role"
}
)
}

# ==========================================

# Attach Worker Node Policy

# ==========================================

resource "aws_iam_role_policy_attachment" "worker_node_policy" {
role       = aws_iam_role.karpenter_node.name
policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# ==========================================

# Attach CNI Policy

# ==========================================

resource "aws_iam_role_policy_attachment" "cni_policy" {
role       = aws_iam_role.karpenter_node.name
policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# ==========================================

# Attach ECR ReadOnly

# ==========================================

resource "aws_iam_role_policy_attachment" "ecr_readonly" {
role       = aws_iam_role.karpenter_node.name
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# ==========================================

# Attach SSM Managed Instance

# ==========================================

resource "aws_iam_role_policy_attachment" "ssm_core" {
role       = aws_iam_role.karpenter_node.name
policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# ==========================================

# Instance Profile

# ==========================================

resource "aws_iam_instance_profile" "karpenter_node" {
name = "${var.cluster_name}-karpenter-instance-profile"

role = aws_iam_role.karpenter_node.name

tags = var.common_tags
}
