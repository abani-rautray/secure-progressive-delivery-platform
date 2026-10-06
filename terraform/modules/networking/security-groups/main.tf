# ==========================================

# EKS Cluster Security Group

# ==========================================

resource "aws_security_group" "eks_cluster" {
name        = "${var.project_name}-${var.environment}-eks-cluster-sg"
description = "Security group for EKS cluster"
vpc_id      = var.vpc_id

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-${var.environment}-eks-cluster-sg"
}
)
}

# ==========================================

# EKS Cluster Ingress

# ==========================================

resource "aws_security_group_rule" "eks_cluster_ingress_https" {
type = "ingress"

from_port = 443
to_port   = 443
protocol  = "tcp"

cidr_blocks = var.allowed_cidr_blocks

security_group_id = aws_security_group.eks_cluster.id
}

# ==========================================

# EKS Cluster Egress

# ==========================================

resource "aws_security_group_rule" "eks_cluster_egress_all" {
type = "egress"

from_port = 0
to_port   = 0
protocol  = "-1"

cidr_blocks = ["0.0.0.0/0"]

security_group_id = aws_security_group.eks_cluster.id
}

# ==========================================

# Worker Node Security Group

# ==========================================

resource "aws_security_group" "worker_nodes" {
name        = "${var.project_name}-${var.environment}-worker-nodes-sg"
description = "Security group for worker nodes"
vpc_id      = var.vpc_id

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-${var.environment}-worker-nodes-sg"

```
  "karpenter.sh/discovery" = var.cluster_name
}
```

)
}

# ==========================================

# Worker Node Ingress From Cluster

# ==========================================

resource "aws_security_group_rule" "worker_ingress_from_cluster" {
type = "ingress"

from_port = 0
to_port   = 65535
protocol  = "tcp"

source_security_group_id = aws_security_group.eks_cluster.id

security_group_id = aws_security_group.worker_nodes.id
}

# ==========================================

# Worker Node Self Communication

# ==========================================

resource "aws_security_group_rule" "worker_self" {
type = "ingress"

from_port = 0
to_port   = 65535
protocol  = "-1"

self = true

security_group_id = aws_security_group.worker_nodes.id
}

# ==========================================

# Worker Node Egress

# ==========================================

resource "aws_security_group_rule" "worker_egress_all" {
type = "egress"

from_port = 0
to_port   = 0
protocol  = "-1"

cidr_blocks = ["0.0.0.0/0"]

security_group_id = aws_security_group.worker_nodes.id
}

# ==========================================

# ALB Security Group

# ==========================================

resource "aws_security_group" "alb" {
name        = "${var.project_name}-${var.environment}-alb-sg"
description = "Security group for ALB"
vpc_id      = var.vpc_id

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-${var.environment}-alb-sg"
}
)
}

# ==========================================

# ALB HTTP

# ==========================================

resource "aws_security_group_rule" "alb_http" {
type = "ingress"

from_port = 80
to_port   = 80
protocol  = "tcp"

cidr_blocks = ["0.0.0.0/0"]

security_group_id = aws_security_group.alb.id
}

# ==========================================

# ALB HTTPS

# ==========================================

resource "aws_security_group_rule" "alb_https" {
type = "ingress"

from_port = 443
to_port   = 443
protocol  = "tcp"

cidr_blocks = ["0.0.0.0/0"]

security_group_id = aws_security_group.alb.id
}

# ==========================================

# ALB Egress

# ==========================================

resource "aws_security_group_rule" "alb_egress" {
type = "egress"

from_port = 0
to_port   = 0
protocol  = "-1"

cidr_blocks = ["0.0.0.0/0"]

security_group_id = aws_security_group.alb.id
}
