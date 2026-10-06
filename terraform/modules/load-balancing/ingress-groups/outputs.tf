# ==========================================

# Frontend Target Group

# ==========================================

output "frontend_target_group_arn" {
value = aws_lb_target_group.frontend.arn
}

# ==========================================

# Backend Target Group

# ==========================================

output "backend_target_group_arn" {
value = aws_lb_target_group.backend.arn
}

# ==========================================

# Canary Target Group

# ==========================================

output "canary_target_group_arn" {
value = aws_lb_target_group.canary.arn
}
