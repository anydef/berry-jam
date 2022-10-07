resource "kubernetes_manifest" "servicemonitor_monitoring_node_exporter" {
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "ServiceMonitor"
    "metadata"   = {
      "labels" = {
        "app.kubernetes.io/name" = "node-exporter"
        "name"                   = "node-exporter"
        "app"                    = "node-exporter"
      }
      "name"      = "node-exporter"
      "namespace" = var.namespace
    }
    "spec" = {
      "endpoints" = [
        {
          "bearerTokenFile" = "/var/run/secrets/kubernetes.io/serviceaccount/token"
          "interval"        = "15s"
          "port"            = "node-exporter"
          "relabelings"     = [
            {
              "action"       = "replace"
              "regex"        = "(.*)"
              "replacement"  = "$1"
              "sourceLabels" = [
                "__meta_kubernetes_pod_node_name",
              ]
              "targetLabel" = "instance"
            },
          ]
        },
      ]
      "jobLabel" = "app.kubernetes.io/name"
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/name" = "node-exporter"
        }
      }
    }
  }
}
