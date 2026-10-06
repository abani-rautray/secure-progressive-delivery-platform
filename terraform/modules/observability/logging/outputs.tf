# ==========================================

# Namespace

# ==========================================

output "namespace" {
value = kubernetes_namespace.logging.metadata[0].name
}

# ==========================================

# Loki

# ==========================================

output "loki_release_name" {
value = helm_release.loki.name
}

# ==========================================

# Fluent Bit

# ==========================================

output "fluentbit_release_name" {
value = helm_release.fluent_bit.name
}
