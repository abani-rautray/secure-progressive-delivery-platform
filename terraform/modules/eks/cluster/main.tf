# ==========================================

# EKS Cluster IAM Role

# ==========================================

resource "aws_iam_role" "eks_cluster_role" {
name = "${var.cluster_name}-cluster-role"

assume_role_policy = jsonencode({
Version = "2012-10-17"

```
Statement = [
  {
    Effect = "Allow"

    Principal = {
      Service = "eks.amazonaws.com"
    }

    Action = "sts:AssumeRole"
  }
]
```

})

tags = merge(
var.common_tags,
{
Name = "${var.cluster_name}-cluster-role"
}
)
}

# ==========================================

# EKS Cluster IAM Policies

# ==========================================

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
role       = aws_iam_role.eks_cluster_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller" {
role       = aws_iam_role.eks_cluster_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

# ==========================================

# KMS Key For Secrets Encryption

# ==========================================

resource "aws_kms_key" "eks" {
description             = "EKS secrets encryption key"
deletion_window_in_days = 7

enable_key_rotation = true

tags = merge(
var.common_tags,
{
Name = "${var.cluster_name}-kms-key"
}
)
}

# ==========================================

# CloudWatch Log Group

# ==========================================

resource "aws_cloudwatch_log_group" "eks" {
name              = "/aws/eks/${var.cluster_name}/cluster"
retention_in_days = 30

tags = merge(
var.common_tags,
{
Name = "${var.cluster_name}-logs"
}
)
}

# ==========================================

# EKS Cluster

# ==========================================

resource "aws_eks_cluster" "this" {
name     = var.cluster_name
version  = var.kubernetes_version

role_arn = aws_iam_role.eks_cluster_role.arn

enabled_cluster_log_types = [
"api",
"audit",
"authenticator",
"controllerManager",
"scheduler"
]

vpc_config {
subnet_ids              = var.private_subnet_ids

```
endpoint_private_access = true
endpoint_public_access  = true

security_group_ids = [
  var.cluster_security_group_id
]
```

}

encryption_config {
provider {
key_arn = aws_kms_key.eks.arn
}

```
resources = ["secrets"]
```

}

depends_on = [
aws_iam_role_policy_attachment.eks_cluster_policy,
aws_iam_role_policy_attachment.eks_vpc_resource_controller,
aws_cloudwatch_log_group.eks
]

tags = merge(
var.common_tags,
{
Name = var.cluster_name
}
)
}
