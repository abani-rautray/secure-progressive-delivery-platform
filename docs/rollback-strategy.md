# Rollback Strategy

## Automatic Rollback

Argo Rollouts automatically rolls back deployments when:

* error rate increases
* latency increases
* health checks fail
* Prometheus analysis fails

Rollback is triggered during:

* canary traffic shifting
* analysis template execution

---

## Manual Rollback

Rollback command:

```bash
kubectl argo rollouts undo backend-rollout -n production
```

---

## Rollback Flow

Canary Failure
│
▼
Prometheus Alert
│
▼
Argo Rollouts Abort
│
▼
Traffic Shift Back To Stable
│
▼
Canary Pods Removed

---

## Recovery Validation

After rollback:

* validate application health
* validate ingress routing
* validate Prometheus metrics
* validate pod readiness
