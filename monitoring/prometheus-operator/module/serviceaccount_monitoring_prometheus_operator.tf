resource "kubernetes_manifest" "serviceaccount_monitoring_prometheus_operator" {
  manifest = {
    "apiVersion" = "v1"
    "automountServiceAccountToken" = false
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/name" = "prometheus-operator"
        "app.kubernetes.io/version" = "0.59.2"
      }
      "name" = "prometheus-operator"
      "namespace" = var.namespace
    }
  }
}
