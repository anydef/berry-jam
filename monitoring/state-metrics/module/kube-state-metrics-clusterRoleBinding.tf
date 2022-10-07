resource "kubernetes_manifest" "clusterrolebinding_kube_state_metrics" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "ClusterRoleBinding"
    "metadata"   = {
      "labels" = {
        "app.kubernetes.io/component" = "exporter"
        "app.kubernetes.io/name"      = "kube-state-metrics"
        "app.kubernetes.io/part-of"   = "kube-prometheus"
        "app.kubernetes.io/version"   = "2.4.2"
      }
      "name" = "kube-state-metrics"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind"     = "ClusterRole"
      "name"     = "kube-state-metrics"
    }
    "subjects" = [
      {
        "kind"      = "ServiceAccount"
        "name"      = "kube-state-metrics"
        "namespace" = var.namespace
      },
    ]
  }
}