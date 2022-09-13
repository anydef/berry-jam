resource "kubernetes_persistent_volume_claim_v1" "grafana" {
  metadata {
    name      = "grafana"
    namespace = "monitoring"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    storage_class_name = "local-path"
  }
}
