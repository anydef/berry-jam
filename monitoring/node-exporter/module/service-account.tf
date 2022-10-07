resource "kubernetes_manifest" "serviceaccount_monitoring_node_exporter" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ServiceAccount"
    "metadata"   = {
      "name"      = "node-exporter"
      "namespace" = var.namespace
    }
  }
}
