# ==========================================

# Frontend Target Group

# ==========================================

resource "aws_lb_target_group" "frontend" {
name = "${var.environment}-frontend-tg"

port     = 80
protocol = "HTTP"

target_type = "ip"

vpc_id = var.vpc_id

health_check {
enabled = true

```
path = "/"

matcher = "200"

healthy_threshold   = 2
unhealthy_threshold = 2

interval = 30
timeout  = 5
```

}

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-frontend-tg"
}
)
}

# ==========================================

# Backend Target Group

# ==========================================

resource "aws_lb_target_group" "backend" {
name = "${var.environment}-backend-tg"

port     = 80
protocol = "HTTP"

target_type = "ip"

vpc_id = var.vpc_id

health_check {
enabled = true

```
path = "/health"

matcher = "200"

healthy_threshold   = 2
unhealthy_threshold = 2

interval = 30
timeout  = 5
```

}

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-backend-tg"
}
)
}

# ==========================================

# Canary Target Group

# ==========================================

resource "aws_lb_target_group" "canary" {
name = "${var.environment}-canary-tg"

port     = 80
protocol = "HTTP"

target_type = "ip"

vpc_id = var.vpc_id

health_check {
enabled = true

```
path = "/health"

matcher = "200"

healthy_threshold   = 2
unhealthy_threshold = 2

interval = 30
timeout  = 5
```

}

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-canary-tg"
}
)
}

# ==========================================

# Frontend Listener Rule

# ==========================================

resource "aws_lb_listener_rule" "frontend" {
listener_arn = var.http_listener_arn

priority = 10

action {
type             = "forward"
target_group_arn = aws_lb_target_group.frontend.arn
}

condition {
path_pattern {
values = [
"/"
]
}
}
}

# ==========================================

# Backend Listener Rule

# ==========================================

resource "aws_lb_listener_rule" "backend" {
listener_arn = var.http_listener_arn

priority = 20

action {
type             = "forward"
target_group_arn = aws_lb_target_group.backend.arn
}

condition {
path_pattern {
values = [
"/api/*"
]
}
}
}

# ==========================================

# Canary Listener Rule

# ==========================================

resource "aws_lb_listener_rule" "canary" {
listener_arn = var.http_listener_arn

priority = 30

action {
type             = "forward"
target_group_arn = aws_lb_target_group.canary.arn
}

condition {
host_header {
values = [
"canary.example.com"
]
}
}
}
