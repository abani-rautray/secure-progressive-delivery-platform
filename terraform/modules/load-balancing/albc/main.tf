# ==========================================

# Kubernetes Namespace

# ==========================================

resource "kubernetes_namespace" "albc" {
metadata {
name = "kube-system"
}
}

# ==========================================

# ALBC Service Account

# ==========================================

resource "kubernetes_service_account" "albc" {
metadata {
name      = "aws-load-balancer-controller"
namespace = "kube-system"

```
annotations = {
  "eks.amazonaws.com/role-arn" = var.albc_irsa_role_arn
}

labels = {
  app = "aws-load-balancer-controller"
}
```

}
}

# ==========================================

# Helm Release

# ==========================================

resource "helm_release" "albc" {
name       = "aws-load-balancer-controller"
repository = "https://aws.github.io/eks-charts"
chart      = "aws-load-balancer-controller"

namespace = "kube-system"

create_namespace = false

values = [
yamlencode({
clusterName = var.cluster_name

```
  region = var.aws_region

  vpcId = var.vpc_id

  serviceAccount = {
    create = false
    name   = kubernetes_service_account.albc.metadata[0].name
  }

  enableShield = false
  enableWaf    = false
  enableWafv2  = false

  replicaCount = 2
})
```

]

depends_on = [
kubernetes_service_account.albc
]
}
