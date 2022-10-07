resource "kubernetes_persistent_volume_v1" "prometheus" {
  metadata {
    name = var.name
    labels = {
      app: var.name
    }
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
