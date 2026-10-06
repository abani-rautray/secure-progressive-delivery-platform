# ==========================================

# Shared Application Load Balancer

# ==========================================

resource "aws_lb" "shared" {
name               = "${var.project_name}-${var.environment}-shared-alb"

internal           = false
load_balancer_type = "application"

security_groups = [
var.alb_security_group_id
]

subnets = var.public_subnet_ids

enable_deletion_protection = false

idle_timeout = 60

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-shared-alb"
}
)
}

# ==========================================

# HTTP Listener

# ==========================================

resource "aws_lb_listener" "http" {
load_balancer_arn = aws_lb.shared.arn

port     = 80
protocol = "HTTP"

default_action {
type = "fixed-response"

```
fixed_response {
  content_type = "text/plain"
  message_body = "ALB Healthy"

  status_code = "200"
}
```

}
}

# ==========================================

# HTTPS Listener

# ==========================================

resource "aws_lb_listener" "https" {
count = var.certificate_arn != "" ? 1 : 0

load_balancer_arn = aws_lb.shared.arn

port     = 443
protocol = "HTTPS"

ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
certificate_arn = var.certificate_arn

default_action {
type = "fixed-response"

```
fixed_response {
  content_type = "text/plain"
  message_body = "HTTPS ALB Healthy"

  status_code = "200"
}
```

}
}
