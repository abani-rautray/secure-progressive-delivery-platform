# ==========================================

# ALBC Outputs

# ==========================================

output "service_account_name" {
value = kubernetes_service_account.albc.metadata[0].name
}

output "helm_release_name" {
value = helm_release.albc.name
}
