resource "kubernetes_manifest" "serviceaccount_monitoring_prometheus" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "name" = var.name
      "namespace" = var.namespace
    }
  }
}
