resource "kubernetes_persistent_volume_v1" "grafana" {
  metadata {
    name      = "grafana"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    capacity     = {
      storage : "10Gi"
    }
    storage_class_name = "nfs"
    persistent_volume_source {
      nfs {
        path   = "/k3s/grafana"
        server = "192.168.178.51"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim_v1" "grafana" {
  metadata {
    name      = "grafana"
    namespace = "monitoring"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
    volume_name = kubernetes_persistent_volume_v1.grafana.metadata[0].name
    storage_class_name = "nfs"
  }
}
