# Security Model

## Identity And Access Management

The platform uses:

* IAM Roles
* IRSA
* OIDC federation

to provide pod-level AWS permissions.

---

## Network Security

Security controls:

* private subnets
* security groups
* network policies
* ingress restrictions
* HTTPS enforcement

---

## Container Security

Security scanning includes:

* Trivy
* SonarQube
* Checkov
* Gitleaks

---

## Kubernetes Security

Cluster hardening:

* Pod Security Standards
* kube-bench CIS validation
* namespace isolation
* least privilege access

---

## Secrets Management

Production recommendations:

* AWS Secrets Manager
* External Secrets Operator
* SOPS encryption

Secrets should never be stored in Git repositories.
