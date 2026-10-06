#!/bin/bash

set -e

echo "=========================================="
echo "Cleanup Kubernetes Resources"
echo "=========================================="

# ==========================================
# Delete Rollouts
# ==========================================

kubectl delete -f kubernetes/apps/canary/ --ignore-not-found

# ==========================================
# Delete Ingress
# ==========================================

kubectl delete -f kubernetes/networking/ingress/ --ignore-not-found

# ==========================================
# Delete Services
# ==========================================

kubectl delete -f kubernetes/networking/services/ --ignore-not-found

# ==========================================
# Delete Policies
# ==========================================

kubectl delete -f kubernetes/networking/policies/ --ignore-not-found

echo "[INFO] Cleanup Completed"