resource "kubernetes_manifest" "service_monitoring_node_exporter" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata"   = {
      "labels" = {
        "app.kubernetes.io/name" = "node-exporter"
      }
      "name"      = "node-exporter"
      "namespace" = var.namespace
    }
    "spec" = {
      "clusterIP" = "None"
      "ports"     = [
        {
          "name"       = "https"
          "port"       = 9100
          "targetPort" = "https"
        },
      ]
      "selector" = {
        "app.kubernetes.io/name" = "node-exporter"
      }
    }
  }
}
