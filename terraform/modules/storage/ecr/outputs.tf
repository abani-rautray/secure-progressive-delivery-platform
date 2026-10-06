# ==========================================

# Frontend Repository

# ==========================================

output "frontend_repository_url" {
value = aws_ecr_repository.frontend.repository_url
}

output "frontend_repository_name" {
value = aws_ecr_repository.frontend.name
}

# ==========================================

# Backend Repository

# ==========================================

output "backend_repository_url" {
value = aws_ecr_repository.backend.repository_url
}

output "backend_repository_name" {
value = aws_ecr_repository.backend.name
}

# ==========================================

# Canary Repository

# ==========================================

output "canary_repository_url" {
value = aws_ecr_repository.canary.repository_url
}

output "canary_repository_name" {
value = aws_ecr_repository.canary.name
}
