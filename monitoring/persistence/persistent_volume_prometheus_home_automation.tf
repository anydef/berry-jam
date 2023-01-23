resource "kubernetes_persistent_volume_v1" "prometheus_home_automation" {
  metadata {
    name = var.prometheus_home_automation_name
  }
  spec {
    access_modes = ["ReadWriteMany"]
    capacity     = {
      storage : var.prometheus_home_automation_storage
    }
    storage_class_name = "nfs"
    persistent_volume_source {
      nfs {
        path   = "${var.nfs_path}/${var.prometheus_home_automation_location}"
        server = var.nfs_server
      }
    }
  }
}