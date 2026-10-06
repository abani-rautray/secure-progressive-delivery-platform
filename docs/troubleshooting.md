# Troubleshooting Guide

## Pods Not Starting

Check:

```bash
kubectl get pods -A
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

---

## Ingress Not Working

Validate:

```bash
kubectl get ingress -A
kubectl describe ingress shared-alb-ingress
```

Check:

* ALBC logs
* security groups
* subnet tags

---

## Rollout Stuck

Check:

```bash
kubectl argo rollouts get rollout backend-rollout -n production
```

Validate:

* Prometheus connectivity
* analysis templates
* canary health

---

## Karpenter Not Scaling

Check:

```bash
kubectl logs -n karpenter deployment/karpenter
```

Validate:

* interruption queue
* IAM permissions
* node pools
* EC2 limits

---

## Terraform Failures

Check:

```bash
terraform validate
terraform plan
```

Validate:

* AWS credentials
* backend state
* provider versions

---

## Observability Issues

Check:

```bash
kubectl get pods -n monitoring
kubectl get pods -n logging
```

Validate:

* Prometheus targets
* Loki connectivity
* Fluent Bit outputs
* Grafana datasources
