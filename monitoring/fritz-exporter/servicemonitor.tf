resource "kubernetes_manifest" "servicemonitor_monitoring_pushgateway" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "ServiceMonitor"
    "metadata"   = {
      "labels" = {
        "app.kubernetes.io/name" = var.name
        "app"                    = var.name
        "name"                   = var.name
      }
      "name"      = var.name
      "namespace" = var.namespace
    }
    "spec" = {
      "endpoints" = [
        {
          "interval"          = "15s"
          "port"              = "http"
          "relabelings"       = []
          "metricRelabelings" = []
          "honorLabels"       = true
        },
      ]
      "jobLabel" = "app.kubernetes.io/name"
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/name" = var.name
        }
      }
    }
  }
}
