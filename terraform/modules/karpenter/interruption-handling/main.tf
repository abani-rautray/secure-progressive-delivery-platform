# ==========================================

# Karpenter SQS Queue

# ==========================================

module "sqs" {
source = "../sqs"

cluster_name = var.cluster_name

common_tags = var.common_tags
}

# ==========================================

# EventBridge Rules

# ==========================================

module "eventbridge" {
source = "../eventbridge"

cluster_name = var.cluster_name

sqs_queue_arn = module.sqs.queue_arn
sqs_queue_url = module.sqs.queue_url

common_tags = var.common_tags
}

# ==========================================

# Kubernetes Namespace

# ==========================================

resource "kubernetes_namespace" "karpenter" {
metadata {
name = "karpenter"
}
}

# ==========================================

# Karpenter Service Account

# ==========================================

resource "kubernetes_service_account" "karpenter" {
metadata {
name      = "karpenter"
namespace = kubernetes_namespace.karpenter.metadata[0].name

```
annotations = {
  "eks.amazonaws.com/role-arn" = var.karpenter_irsa_role_arn
}
```

}
}

# ==========================================

# Karpenter Helm Release

# ==========================================

resource "helm_release" "karpenter" {
name = "karpenter"

repository = "oci://public.ecr.aws/karpenter"
chart      = "karpenter"

namespace = kubernetes_namespace.karpenter.metadata[0].name

create_namespace = false

values = [
yamlencode({
settings = {
clusterName       = var.cluster_name
interruptionQueue = module.sqs.queue_name
}

```
  serviceAccount = {
    create = false
    name   = kubernetes_service_account.karpenter.metadata[0].name
  }

  controller = {
    resources = {
      requests = {
        cpu    = "500m"
        memory = "512Mi"
      }

      limits = {
        cpu    = "1"
        memory = "1Gi"
      }
    }
  }
})
```

]

depends_on = [
kubernetes_service_account.karpenter,
module.eventbridge
]
}
