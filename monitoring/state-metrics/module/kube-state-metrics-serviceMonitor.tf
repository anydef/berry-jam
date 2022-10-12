resource "kubernetes_manifest" "servicemonitor_monitoring_kube_state_metrics" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "ServiceMonitor"
    "metadata"   = {
      "labels" = {
        "app.kubernetes.io/component" = "exporter"
        "app.kubernetes.io/name"      = "kube-state-metrics"
        "app.kubernetes.io/part-of"   = "kube-prometheus"
        "app.kubernetes.io/version"   = "1.9.7"
        "prometheus-enabled"          = "true"
        "name"                        = "kube-state-metrics"
        "app"                         = "kube-state-metrics"
      }
      "name"      = "kube-state-metrics"
      "namespace" = var.namespace
    }
    "spec" = {
      "endpoints" = [
        {
          "honorLabels" = true
          "interval"    = "30s"
          "port"        = "http-metrics"
        },
      ]
      "jobLabel"          = "app.kubernetes.io/name"
      "namespaceSelector" = {
        "matchNames" = [
          var.namespace,
        ]
      }
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/component" = "exporter"
          "app.kubernetes.io/name"      = "kube-state-metrics"
          "app.kubernetes.io/part-of"   = "kube-prometheus"
        }
      }
    }
  }
}
