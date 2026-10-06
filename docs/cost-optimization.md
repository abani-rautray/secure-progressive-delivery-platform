# Cost Optimization

## Karpenter Spot Instances

Karpenter uses:

* Spot instances
* dynamic node provisioning
* consolidation

to reduce infrastructure cost.

---

## Shared ALB

Ingress groups allow:

* one ALB
* multiple applications

reducing AWS Load Balancer costs.

---

## Loki + S3

Loki stores logs in S3:

* cheaper than Elasticsearch
* lower operational overhead
* scalable retention

---

## Environment Sizing

### Development

* minimal replicas
* reduced resources

### Staging

* moderate scaling

### Production

* high availability
* autoscaling enabled

---

## Autoscaling

The platform uses:

* HPA
* Karpenter

for efficient compute utilization.
