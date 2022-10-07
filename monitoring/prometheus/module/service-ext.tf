resource "kubernetes_manifest" "service_monitoring_prometheus_external" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "name" = "prometheus-external"
      "namespace" = var.namespace
    }
    "spec" = {
#      "loadBalancerIP" = "192.168.0.205"
      "ports" = [
        {
          "name" = "web"
          "port" = 9090
          "protocol" = "TCP"
          "targetPort" = 9090
        },
      ]
      "selector" = {
        "prometheus" = var.deployment_name
      }
      "type" = "LoadBalancer"
    }
  }
}
