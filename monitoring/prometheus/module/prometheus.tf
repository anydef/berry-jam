resource "kubernetes_manifest" "prometheus_monitoring_prometheus_persistant" {
  depends_on = [kubernetes_persistent_volume_v1.prometheus]
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "Prometheus"
    "metadata"   = {
      "name"      = var.deployment_name
      "namespace" = var.namespace
    }
    "spec" = {
      "image" = "quay.io/prometheus/prometheus:v2.39.0"
      "replicas"  = 1
      "resources" = {
        "requests" = {
          "memory" = "600Mi"
        }
      }
      "nodeSelector" = {
        "node-type" = "worker"
      }
      "retention"       = "30d"
      "retentionSize" = "500MB"
      "securityContext" = {
        "fsGroup"      = 2000
        "runAsNonRoot" = true
        "runAsUser"    = 1000
      }
      "serviceAccountName"     = "prometheus"
      "serviceMonitorSelector" = {
        "matchExpressions" = [
          {
            "key"      = "app"
            "operator" = "In"
            "values"   = [
              "kube-state-metrics",
              "node-exporter",
              "kubelet",
              "traefik",
              "pushgateway"
#              "grafana",
            ]
          }
        ]
      }
      "storage" = {
        "volumeClaimTemplate" = {
          "spec" = {
            "accessModes" = [
              "ReadWriteMany",
            ]
            "resources" = {
              "requests" = {
                "storage" = "20Gi"
              }
            }
            volumeName       = kubernetes_persistent_volume_v1.prometheus.metadata[0].name
            storageClassName = "nfs"
          }
        }
      }
    }
  }
}
