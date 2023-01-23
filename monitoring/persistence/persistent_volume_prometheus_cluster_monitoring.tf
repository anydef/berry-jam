resource "kubernetes_persistent_volume_v1" "prometheus_cluster_monitoring" {
  metadata {
    name = var.prometheus_cluster_monitoring_name
  }
  spec {
    access_modes = ["ReadWriteMany"]
    capacity     = {
      storage : var.prometheus_cluster_monitoring_storage
    }
    storage_class_name = "nfs"
    persistent_volume_source {
      nfs {
        path   = "${var.nfs_path}/${var.prometheus_cluster_monitoring_location}"
        server = var.nfs_server
      }
    }
  }
}