# ==========================================

# Frontend Repository

# ==========================================

resource "aws_ecr_repository" "frontend" {
name = "${var.project_name}/frontend"

image_tag_mutability = "IMMUTABLE"

image_scanning_configuration {
scan_on_push = true
}

encryption_configuration {
encryption_type = "AES256"
}

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-frontend-ecr"
}
)
}

# ==========================================

# Backend Repository

# ==========================================

resource "aws_ecr_repository" "backend" {
name = "${var.project_name}/backend"

image_tag_mutability = "IMMUTABLE"

image_scanning_configuration {
scan_on_push = true
}

encryption_configuration {
encryption_type = "AES256"
}

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-backend-ecr"
}
)
}

# ==========================================

# Canary Repository

# ==========================================

resource "aws_ecr_repository" "canary" {
name = "${var.project_name}/canary"

image_tag_mutability = "IMMUTABLE"

image_scanning_configuration {
scan_on_push = true
}

encryption_configuration {
encryption_type = "AES256"
}

tags = merge(
var.common_tags,
{
Name = "${var.project_name}-canary-ecr"
}
)
}

# ==========================================

# Lifecycle Policy

# ==========================================

resource "aws_ecr_lifecycle_policy" "frontend" {
repository = aws_ecr_repository.frontend.name

policy = jsonencode({
rules = [
{
rulePriority = 1

```
    description = "Keep last 20 images"

    selection = {
      tagStatus     = "any"
      countType     = "imageCountMoreThan"
      countNumber   = 20
    }

    action = {
      type = "expire"
    }
  }
]
```

})
}

resource "aws_ecr_lifecycle_policy" "backend" {
repository = aws_ecr_repository.backend.name

policy = jsonencode({
rules = [
{
rulePriority = 1

```
    description = "Keep last 20 images"

    selection = {
      tagStatus     = "any"
      countType     = "imageCountMoreThan"
      countNumber   = 20
    }

    action = {
      type = "expire"
    }
  }
]
```

})
}

resource "aws_ecr_lifecycle_policy" "canary" {
repository = aws_ecr_repository.canary.name

policy = jsonencode({
rules = [
{
rulePriority = 1

```
    description = "Keep last 20 images"

    selection = {
      tagStatus     = "any"
      countType     = "imageCountMoreThan"
      countNumber   = 20
    }

    action = {
      type = "expire"
    }
  }
]
```

})
}
