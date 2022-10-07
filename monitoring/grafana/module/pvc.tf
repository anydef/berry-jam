resource "kubernetes_persistent_volume_v1" "grafana" {
  metadata {
    name = var.name
  }
  spec {
    access_modes = ["ReadWriteMany"]
    capacity     = {
      storage : var.storage
    }
    storage_class_name = "nfs"
    persistent_volume_source {
      nfs {
        path   = var.nfs_path
        server = var.nfs_server
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim_v1" "grafana" {
  depends_on = [kubernetes_persistent_volume_v1.grafana]
  metadata {
    name      = "grafana"
    namespace = var.namespace
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = var.storage
      }
    }
    volume_name        = kubernetes_persistent_volume_v1.grafana.metadata[0].name
    storage_class_name = "nfs"
  }
}
