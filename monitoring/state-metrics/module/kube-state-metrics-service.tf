resource "kubernetes_manifest" "service_monitoring_kube_state_metrics" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata"   = {
      "labels" = {
        "app.kubernetes.io/component" = "exporter"
        "app.kubernetes.io/name"      = "kube-state-metrics"
        "app.kubernetes.io/part-of"   = "kube-prometheus"
        "app.kubernetes.io/version"   = "2.4.2"
      }
      "name"      = "kube-state-metrics"
      "namespace" = var.namespace
    }
    "spec" = {
      "clusterIP" = "None"
      "ports"     = [
        {
          "name"       = "http-metrics"
          "port"       = 8080
          "targetPort" = "http-metrics"
        },
        {
          "name"       = "telemetry"
          "port"       = 8081
          "targetPort" = "telemetry"
        },
      ]
      "selector" = {
        "app.kubernetes.io/component" = "exporter"
        "app.kubernetes.io/name"      = "kube-state-metrics"
        "app.kubernetes.io/part-of"   = "kube-prometheus"
      }
    }
  }
}
