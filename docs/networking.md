# Networking Architecture

## VPC Design

The platform uses:

* public subnets
* private subnets
* NAT Gateway
* route tables
* VPC endpoints

---

## Traffic Flow

Internet
│
▼
AWS ALB
│
▼
Ingress
│
▼
Kubernetes Services
│
▼
Pods

---

## ALB Architecture

AWS Load Balancer Controller manages:

* ALBs
* listeners
* target groups
* ingress routing

---

## Internal Traffic

Internal workloads communicate through:

* ClusterIP services
* Kubernetes DNS
* NetworkPolicies

---

## Security Controls

Networking protections:

* security groups
* private networking
* restricted ingress
* pod isolation
