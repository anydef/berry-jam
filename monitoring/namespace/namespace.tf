resource "kubernetes_namespace" "monitoring-namespace" {
  metadata {
    name = var.namespace
  }
}