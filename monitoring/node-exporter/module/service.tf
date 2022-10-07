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
          "name"       = "node-exporter"
          "protocol"   = "TCP"
          "port"       = 9100
          "targetPort" = 9100
        },
      ]
      "selector" = {
        "app.kubernetes.io/name" = "node-exporter"
      }
    }
  }
}
