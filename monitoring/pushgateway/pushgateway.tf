module "pushgateway" {
  source = "git@github.com:anydef/tf-modules.git//pushgateway"
  name = "pushgateway"
  namespace = var.namespace
}