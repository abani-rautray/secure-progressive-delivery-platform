# ==========================================

# Shared ALB Outputs

# ==========================================

output "alb_arn" {
value = aws_lb.shared.arn
}

output "alb_dns_name" {
value = aws_lb.shared.dns_name
}

output "alb_zone_id" {
value = aws_lb.shared.zone_id
}

# ==========================================

# Listener Outputs

# ==========================================

output "http_listener_arn" {
value = aws_lb_listener.http.arn
}

output "https_listener_arn" {
value = try(
aws_lb_listener.https[0].arn,
null
)
}
