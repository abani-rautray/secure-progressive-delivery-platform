# ==========================================

# Namespace

# ==========================================

output "namespace" {
value = kubernetes_namespace.monitoring.metadata[0].name
}

# ==========================================

# Helm Release

# ==========================================

output "helm_release_name" {
value = helm_release.kube_prometheus_stack.name
}
