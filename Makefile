# ==========================================

# Variables

# ==========================================

AWS_REGION ?= ap-south-1
ENV ?= dev
CLUSTER_NAME ?= secure-platform-eks

TERRAFORM_DIR = terraform/environments/$(ENV)

# ==========================================

# Help

# ==========================================

.PHONY: help

help:
@echo ""
@echo "Available Commands:"
@echo ""
@echo "Infrastructure:"
@echo "  make init               Initialize Terraform"
@echo "  make plan               Terraform Plan"
@echo "  make apply              Terraform Apply"
@echo "  make destroy            Destroy Infrastructure"
@echo ""
@echo "Kubernetes:"
@echo "  make kubeconfig         Update kubeconfig"
@echo "  make bootstrap          Install platform components"
@echo "  make deploy-apps        Deploy ArgoCD applications"
@echo ""
@echo "Helm:"
@echo "  make helm-lint          Lint Helm charts"
@echo ""
@echo "Security:"
@echo "  make trivy              Run Trivy scan"
@echo "  make checkov            Run Checkov scan"
@echo "  make gitleaks           Run Gitleaks scan"
@echo ""
@echo "Utilities:"
@echo "  make cleanup            Cleanup temporary resources"
@echo ""

# ==========================================

# Terraform

# ==========================================

.PHONY: init
init:
cd $(TERRAFORM_DIR) && terraform init

.PHONY: fmt
fmt:
terraform fmt -recursive

.PHONY: validate
validate:
cd $(TERRAFORM_DIR) && terraform validate

.PHONY: plan
plan:
cd $(TERRAFORM_DIR) && terraform plan -out=tfplan

.PHONY: apply
apply:
cd $(TERRAFORM_DIR) && terraform apply -auto-approve tfplan

.PHONY: destroy
destroy:
cd $(TERRAFORM_DIR) && terraform destroy -auto-approve

# ==========================================

# AWS / EKS

# ==========================================

.PHONY: kubeconfig
kubeconfig:
aws eks update-kubeconfig
--region $(AWS_REGION)
--name $(CLUSTER_NAME)

# ==========================================

# Bootstrap Platform Components

# ==========================================

.PHONY: bootstrap
bootstrap:
chmod +x scripts/bootstrap.sh
./scripts/bootstrap.sh

# ==========================================

# Deploy ArgoCD Applications

# ==========================================

.PHONY: deploy-apps
deploy-apps:
kubectl apply -f argocd/projects/
kubectl apply -f argocd/applications/

# ==========================================

# Helm

# ==========================================

.PHONY: helm-lint
helm-lint:
helm lint helm/infrastructure/albc
helm lint helm/infrastructure/karpenter
helm lint helm/observability/prometheus
helm lint helm/observability/grafana
helm lint helm/observability/loki
helm lint helm/observability/fluent-bit

# ==========================================

# Security Scans

# ==========================================

.PHONY: trivy
trivy:
trivy fs .

.PHONY: checkov
checkov:
checkov -d .

.PHONY: gitleaks
gitleaks:
gitleaks detect --source .

# ==========================================

# Kubernetes Validation

# ==========================================

.PHONY: kubeval
kubeval:
kubeval kubernetes/**/*.yaml

# ==========================================

# Docker

# ==========================================

.PHONY: docker-build
docker-build:
docker build -t secure-platform-app ./app

# ==========================================

# Cleanup

# ==========================================

.PHONY: cleanup
cleanup:
chmod +x scripts/cleanup.sh
./scripts/cleanup.sh

# ==========================================

# Full Pipeline

# ==========================================

.PHONY: all
all: fmt validate plan apply bootstrap deploy-apps
