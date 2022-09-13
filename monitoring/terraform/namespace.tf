resource "kubernetes_namespace" "monitoring-namespace" {
  metadata {
    name = "monitoring"
  }
}