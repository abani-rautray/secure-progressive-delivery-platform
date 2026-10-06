#!/bin/bash

set -e

echo "=========================================="
echo "Destroy Infrastructure"
echo "=========================================="

cd terraform/environments/dev

terraform destroy -auto-approve

cd ../../..

echo "[INFO] Infrastructure Destroyed"