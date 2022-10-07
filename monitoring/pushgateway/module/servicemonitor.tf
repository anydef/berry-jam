resource "kubernetes_manifest" "servicemonitor_monitoring_pushgateway" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "ServiceMonitor"
    "metadata"   = {
      "labels" = {
        "app.kubernetes.io/name" = "pushgateway"
        "name"                   = "pushgateway"
      }
      "name"      = "pushgateway"
      "namespace" = var.namespace
    }
    "spec" = {
      "endpoints" = [
        {
#          "enabled"           = true
          "interval"          = "1m"
          "port"              = "http"
          "relabelings"       = []
          "metricRelabelings" = []
          "honorLabels"       = true
          "scheme"            = "http"
        },
      ]
      "jobLabel" = "app.kubernetes.io/name"
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/name" = "pushgateway"
        }
      }
    }
  }
}
