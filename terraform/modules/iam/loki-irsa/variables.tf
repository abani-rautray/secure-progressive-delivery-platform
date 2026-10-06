variable "name_prefix" {
  description = "Prefix used for Loki IAM resources."
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider."
  type        = string
}

variable "oidc_issuer" {
  description = "EKS OIDC issuer without https://."
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace where Loki runs."
  type        = string
  default     = "loki"
}

variable "service_account_name" {
  description = "Kubernetes service account used by Loki."
  type        = string
  default     = "loki"
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket used by Loki."
  type        = string
}

variable "tags" {
  description = "Tags for IAM resources."
  type        = map(string)
  default     = {}
}