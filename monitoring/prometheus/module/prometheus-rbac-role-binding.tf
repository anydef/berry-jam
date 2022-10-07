resource "kubernetes_manifest" "clusterrolebinding_prometheus" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "name" = var.name
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = var.name
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = var.name
        "namespace" = var.namespace
      },
    ]
  }
}
