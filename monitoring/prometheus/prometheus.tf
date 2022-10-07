module "prometheus" {
  source = "./module"
  namespace = var.namespace
  storage = var.prometheus_storage
  nfs_path = var.prometheus_nfs_path
  nfs_server = var.nfs_server
}