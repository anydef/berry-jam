resource "kubernetes_manifest" "service_monitoring_prometheus" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "name" = var.name
      "namespace" = var.namespace
    }
    "spec" = {
      "ports" = [
        {
          "name" = "web"
          "port" = 9090
          "targetPort" = "web"
        },
      ]
      "selector" = {
        "prometheus" = var.deployment_name
      }
      "sessionAffinity" = "ClientIP"
    }
  }
}
