# Deployment Flow

## CI/CD Flow

Developer Push
│
▼
GitHub Actions
│
├── CI Tests
├── Security Scans
├── Docker Build
├── Push To ECR
├── Terraform Plan
└── Terraform Apply
│
▼
ArgoCD Sync
│
▼
Argo Rollouts
│
▼
Canary Deployment

---

## Canary Deployment Flow

1. New container image is pushed to ECR.
2. ArgoCD detects Git changes.
3. Argo Rollouts deploys canary pods.
4. ALB shifts a small percentage of traffic.
5. Prometheus metrics are evaluated.
6. If metrics are healthy:

   * rollout continues
7. If metrics fail:

   * automatic rollback occurs

---

## Environment Promotion

dev
│
▼
staging
│
▼
production

Each environment uses:

* separate overlays
* different image tags
* different scaling rules
* different ingress domains
