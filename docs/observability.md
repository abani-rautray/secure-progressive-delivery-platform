# Observability

## Monitoring Stack

Monitoring components:

* Prometheus
* Grafana
* Alertmanager

Metrics collected:

* CPU
* memory
* pod health
* rollout metrics
* node metrics

---

## Logging Stack

Logging components:

* Loki
* Fluent Bit

Log sources:

* application logs
* Kubernetes logs
* container logs

---

## Alerting

Prometheus alerts include:

* high CPU
* high memory
* rollout failures
* node failures

---

## Dashboards

Grafana dashboards provide:

* infrastructure visibility
* rollout visibility
* cluster health
* workload health

---

## Progressive Delivery Metrics

Argo Rollouts integrates with Prometheus for:

* success rate analysis
* canary validation
* automatic rollback
