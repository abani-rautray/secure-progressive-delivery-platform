# Secure Progressive Delivery Platform Architecture

## Overview

This platform provides a production-grade Kubernetes DevSecOps architecture on AWS using:

* Terraform
* Amazon EKS
* Karpenter
* ArgoCD
* Argo Rollouts
* AWS Load Balancer Controller
* Prometheus
* Grafana
* Loki
* Fluent Bit

The platform supports:

* GitOps
* progressive delivery
* canary deployments
* autoscaling
* observability
* DevSecOps security scanning

---

## High-Level Architecture

Internet
│
▼
AWS ALB
│
▼
AWS Load Balancer Controller
│
▼
Ingress
│
▼
Argo Rollouts
│
├── Stable Service
└── Canary Service
│
▼
Kubernetes Pods
│
▼
Amazon EKS
│
▼
Karpenter Autoscaling

---

## Infrastructure Components

### Networking

* VPC
* Public Subnets
* Private Subnets
* NAT Gateway
* Route Tables
* Security Groups
* VPC Endpoints

### Kubernetes

* Amazon EKS
* Managed Node Groups
* Karpenter
* OIDC Provider
* IRSA

### GitOps

* ArgoCD
* ApplicationSets
* Kustomize overlays

### Progressive Delivery

* Argo Rollouts
* Canary deployments
* ALB traffic routing
* Prometheus analysis

### Observability

* Prometheus
* Grafana
* Loki
* Fluent Bit

### Security

* Trivy
* Checkov
* Gitleaks
* SonarQube
* kube-bench
* OWASP ZAP
