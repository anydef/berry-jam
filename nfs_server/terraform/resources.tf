resource "kubernetes_namespace_v1" "storage" {
  metadata {
    name = "storage"
    labels = {}
  }
}
