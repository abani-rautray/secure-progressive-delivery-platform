#!/bin/bash

set -e

APP_NAME=${1:-backend-rollout}

echo "=========================================="
echo "Rollback Application"
echo "=========================================="

echo "[INFO] Rolling back: $APP_NAME"

kubectl argo rollouts undo $APP_NAME -n production

echo "[INFO] Rollback Triggered"