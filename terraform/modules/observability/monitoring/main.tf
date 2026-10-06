# ==========================================

# Monitoring Namespace

# ==========================================

resource "kubernetes_namespace" "monitoring" {
metadata {
name = "monitoring"

```
labels = {
  app = "monitoring"
}
```

}
}

# ==========================================

# kube-prometheus-stack

# ==========================================

resource "helm_release" "kube_prometheus_stack" {
name = "kube-prometheus-stack"

repository = "https://prometheus-community.github.io/helm-charts"

chart = "kube-prometheus-stack"

namespace = kubernetes_namespace.monitoring.metadata[0].name

create_namespace = false

timeout = 1200

values = [
yamlencode({

```
  grafana = {
    enabled = true

    adminPassword = "admin123"

    persistence = {
      enabled = true
      size    = "10Gi"
    }

    service = {
      type = "ClusterIP"
    }
  }

  prometheus = {
    enabled = true

    prometheusSpec = {
      retention = "15d"

      storageSpec = {
        volumeClaimTemplate = {
          spec = {
            accessModes = ["ReadWriteOnce"]

            resources = {
              requests = {
                storage = "50Gi"
              }
            }
          }
        }
      }

      serviceMonitorSelectorNilUsesHelmValues = false
    }
  }

  alertmanager = {
    enabled = true

    alertmanagerSpec = {
      storage = {
        volumeClaimTemplate = {
          spec = {
            accessModes = ["ReadWriteOnce"]

            resources = {
              requests = {
                storage = "10Gi"
              }
            }
          }
        }
      }
    }
  }

  kubeStateMetrics = {
    enabled = true
  }

  nodeExporter = {
    enabled = true
  }

  prometheusOperator = {
    enabled = true
  }
})
```

]
}
