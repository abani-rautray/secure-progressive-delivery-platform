# ==========================================

# Terraform Role Outputs

# ==========================================

output "terraform_role_arn" {
value = aws_iam_role.terraform.arn
}

output "terraform_role_name" {
value = aws_iam_role.terraform.name
}
