resource "kubernetes_manifest" "service_monitoring_prometheus_operator" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/name" = "prometheus-operator"
        "app.kubernetes.io/version" = "0.59.2"
      }
      "name" = "prometheus-operator"
      "namespace" = var.namespace
    }
    "spec" = {
      "clusterIP" = "None"
      "ports" = [
        {
          "name" = "http"
          "port" = 8080
          "targetPort" = "http"
        },
      ]
      "selector" = {
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/name" = "prometheus-operator"
      }
    }
  }
}
