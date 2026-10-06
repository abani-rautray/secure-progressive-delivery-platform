# ==========================================

# Event Rules

# ==========================================

output "spot_interruption_rule" {
value = aws_cloudwatch_event_rule.spot_interruption.name
}

output "rebalance_rule" {
value = aws_cloudwatch_event_rule.rebalance.name
}

output "maintenance_rule" {
value = aws_cloudwatch_event_rule.maintenance.name
}

output "state_change_rule" {
value = aws_cloudwatch_event_rule.state_change.name
}
