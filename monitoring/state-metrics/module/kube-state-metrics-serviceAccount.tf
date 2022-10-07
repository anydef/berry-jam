resource "kubernetes_manifest" "serviceaccount_monitoring_kube_state_metrics" {
  manifest = {
    "apiVersion"                   = "v1"
    "automountServiceAccountToken" = false
    "kind"                         = "ServiceAccount"
    "metadata"                     = {
      "labels" = {
        "app.kubernetes.io/component" = "exporter"
        "app.kubernetes.io/name"      = "kube-state-metrics"
        "app.kubernetes.io/part-of"   = "kube-prometheus"
        "app.kubernetes.io/version"   = "2.4.2"
      }
      "name"      = "kube-state-metrics"
      "namespace" = var.namespace
    }
  }
}
