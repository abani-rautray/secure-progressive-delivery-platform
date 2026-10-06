# ==========================================

# Get EKS Cluster Details

# ==========================================

data "aws_eks_cluster" "this" {
name = var.cluster_name
}

# ==========================================

# TLS Certificate For OIDC

# ==========================================

data "tls_certificate" "this" {
url = data.aws_eks_cluster.this.identity[0].oidc[0].issuer
}

# ==========================================

# IAM OpenID Connect Provider

# ==========================================

resource "aws_iam_openid_connect_provider" "this" {
url = data.aws_eks_cluster.this.identity[0].oidc[0].issuer

client_id_list = [
"sts.amazonaws.com"
]

thumbprint_list = [
data.tls_certificate.this.certificates[0].sha1_fingerprint
]

tags = merge(
var.common_tags,
{
Name = "${var.cluster_name}-oidc-provider"
}
)
}
