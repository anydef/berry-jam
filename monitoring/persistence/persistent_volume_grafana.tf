resource "kubernetes_persistent_volume_v1" "grafana" {
  metadata {
    name = var.grafana_name
  }
  spec {
    access_modes = ["ReadWriteMany"]
    capacity     = {
      storage : var.grafana_storage
    }
    storage_class_name = "nfs"
    persistent_volume_source {
      nfs {
        path   = "${var.nfs_path}/${var.grafana_location}"
        server = var.nfs_server
      }
    }
    mount_options = ["nfsvers=4.1"]
#    mount_options = ["nfsvers=4.1", "resvport"]
  }
}