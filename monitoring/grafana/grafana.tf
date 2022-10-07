module "grafana" {
  source        = "./module"
  name          = "grafana"
  namespace     = var.namespace
  storage       = var.storage
  nfs_path      = var.nfs_path
  nfs_server    = var.nfs_server
  grafana_image = var.grafana_image
}
