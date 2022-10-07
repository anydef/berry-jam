resource "kubernetes_manifest" "servicemonitor_monitoring_traefik" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "ServiceMonitor"
    "metadata"   = {
      "labels" = {
        "app"     = "traefik"
        "name"    = "traefik"
        "release" = "prometheus"
      }
      "name"      = "traefik"
      "namespace" = var.namespace
    }
    "spec" = {
      "endpoints" = [
        {
          "port" = "metrics"
        },
      ]
      "namespaceSelector" = {
        "matchNames" = [
          "kube-system",
        ]
      }
      "selector" = {
        "matchLabels" = {
          "app" = "traefik"
        }
      }
    }
  }
}
