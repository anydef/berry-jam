module "node-exporter" {
  source = "git@github.com:anydef/tf-modules.git//node-exporter"
  namespace = var.namespace
}