#!/bin/bash

set -e

echo "=========================================="
echo "Bootstrap Secure Platform"
echo "=========================================="

# ==========================================
# Terraform Init
# ==========================================

echo "[INFO] Terraform Init"

cd terraform/environments/dev

terraform init

terraform validate

cd ../../..

# ==========================================
# Create Namespace
# ==========================================

echo "[INFO] Creating Kubernetes Namespaces"

kubectl apply -f kubernetes/base/namespace.yaml

# ==========================================
# Apply Base Resources
# ==========================================

echo "[INFO] Applying Base Resources"

kubectl apply -f kubernetes/base/

# ==========================================
# Apply Services
# ==========================================

echo "[INFO] Applying Services"

kubectl apply -f kubernetes/networking/services/

# ==========================================
# Apply Policies
# ==========================================

echo "[INFO] Applying Policies"

kubectl apply -f kubernetes/networking/policies/

echo "[INFO] Bootstrap Completed"