# ==========================================

# Logging Namespace

# ==========================================

resource "kubernetes_namespace" "logging" {
metadata {
name = "logging"

```
labels = {
  app = "logging"
}
```

}
}

# ==========================================

# Loki Helm Release

# ==========================================

resource "helm_release" "loki" {
name = "loki"

repository = "https://grafana.github.io/helm-charts"
chart      = "loki"

namespace = kubernetes_namespace.logging.metadata[0].name

create_namespace = false

timeout = 1200

values = [
yamlencode({

```
  loki = {
    auth_enabled = false
  }

  singleBinary = {
    replicas = 1
  }

  deploymentMode = "SingleBinary"

  backend = {
    replicas = 0
  }

  read = {
    replicas = 0
  }

  write = {
    replicas = 0
  }

  chunksCache = {
    enabled = false
  }

  test = {
    enabled = false
  }

  monitoring = {
    serviceMonitor = {
      enabled = true
    }
  }

  loki = {
    schemaConfig = {
      configs = [
        {
          from = "2024-01-01"

          store  = "tsdb"
          object_store = "s3"

          schema = "v13"

          index = {
            prefix = "loki_index_"
            period = "24h"
          }
        }
      ]
    }

    storage = {
      type = "s3"

      bucketNames = {
        chunks = var.loki_bucket_name
        ruler  = var.loki_bucket_name
        admin  = var.loki_bucket_name
      }

      s3 = {
        region = var.aws_region
      }
    }
  }
})
```

]
}

# ==========================================

# Fluent Bit Helm Release

# ==========================================

resource "helm_release" "fluent_bit" {
name = "fluent-bit"

repository = "https://fluent.github.io/helm-charts"
chart      = "fluent-bit"

namespace = kubernetes_namespace.logging.metadata[0].name

create_namespace = false

timeout = 1200

values = [
yamlencode({

```
  serviceAccount = {
    create = true

    name = "fluent-bit"

    annotations = {
      "eks.amazonaws.com/role-arn" = var.fluentbit_irsa_role_arn
    }
  }

  config = {
    service = <<-EOT
      [SERVICE]
          Flush         1
          Daemon        Off
          Log_Level     info
          Parsers_File  parsers.conf
    EOT

    inputs = <<-EOT
      [INPUT]
          Name              tail
          Path              /var/log/containers/*.log
          Parser            docker
          Tag               kube.*
          Mem_Buf_Limit     5MB
          Skip_Long_Lines   On
          Refresh_Interval  10
    EOT

    outputs = <<-EOT
      [OUTPUT]
          Name        loki
          Match       *
          Host        loki-gateway
          Port        80
          Labels      job=fluentbit
    EOT
  }
})
```

]

depends_on = [
helm_release.loki
]
}
