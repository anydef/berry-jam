module "grafana" {
  source        = "./module"
  name          = "grafana"
  namespace     = var.namespace
  storage       = var.grafana_storage
  nfs_path      = var.grafana_nfs_path
  nfs_server    = var.nfs_server
  grafana_image = var.grafana_image
}
