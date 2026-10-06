#!/bin/bash

set -e

echo "=========================================="
echo "Install DevOps Tools"
echo "=========================================="

# ==========================================
# kubectl
# ==========================================

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

sudo mv kubectl /usr/local/bin/

# ==========================================
# Terraform
# ==========================================

sudo apt-get update

sudo apt-get install -y gnupg software-properties-common curl

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

sudo apt-add-repository \
"deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt-get update && sudo apt-get install terraform -y

# ==========================================
# Helm
# ==========================================

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# ==========================================
# ArgoCD CLI
# ==========================================

curl -sSL -o argocd \
https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64

chmod +x argocd

sudo mv argocd /usr/local/bin/

# ==========================================
# AWS CLI
# ==========================================

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install

echo "[INFO] Tools Installation Completed"