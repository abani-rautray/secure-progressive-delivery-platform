# ==========================================

# IAM Role For Worker Nodes

# ==========================================

resource "aws_iam_role" "nodegroup" {
name = "${var.cluster_name}-nodegroup-role"

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
Name = "${var.cluster_name}-nodegroup-role"
}
)
}

# ==========================================

# IAM Policies For Worker Nodes

# ==========================================

resource "aws_iam_role_policy_attachment" "worker_node_policy" {
role       = aws_iam_role.nodegroup.name
policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
role       = aws_iam_role.nodegroup.name
policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr_readonly" {
role       = aws_iam_role.nodegroup.name
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "ssm_managed" {
role       = aws_iam_role.nodegroup.name
policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# ==========================================

# Launch Template

# ==========================================

resource "aws_launch_template" "nodegroup" {
name_prefix = "${var.cluster_name}-nodegroup-"

update_default_version = true

block_device_mappings {
device_name = "/dev/xvda"

```
ebs {
  volume_size           = var.disk_size
  volume_type           = "gp3"
  encrypted             = true
  delete_on_termination = true
}
```

}

monitoring {
enabled = true
}

metadata_options {
http_endpoint = "enabled"
http_tokens   = "required"
}

tag_specifications {
resource_type = "instance"

```
tags = merge(
  var.common_tags,
  {
    Name = "${var.cluster_name}-worker-node"

    "karpenter.sh/discovery" = var.cluster_name
  }
)
```

}

tags = var.common_tags
}

# ==========================================

# Managed Node Group

# ==========================================

resource "aws_eks_node_group" "this" {
cluster_name    = var.cluster_name
node_group_name = "${var.cluster_name}-managed-ng"

node_role_arn = aws_iam_role.nodegroup.arn

subnet_ids = var.private_subnet_ids

ami_type       = "AL2023_x86_64_STANDARD"
capacity_type  = var.capacity_type
instance_types = var.instance_types

launch_template {
id      = aws_launch_template.nodegroup.id
version = "$Latest"
}

scaling_config {
desired_size = var.desired_size
min_size     = var.min_size
max_size     = var.max_size
}

update_config {
max_unavailable = 1
}

labels = {
workload = "system"
}

tags = merge(
var.common_tags,
{
Name = "${var.cluster_name}-managed-ng"
}
)

depends_on = [
aws_iam_role_policy_attachment.worker_node_policy,
aws_iam_role_policy_attachment.cni_policy,
aws_iam_role_policy_attachment.ecr_readonly,
aws_iam_role_policy_attachment.ssm_managed
]
}
