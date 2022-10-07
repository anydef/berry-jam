module "pushgateway" {
  source = "./module"
  name = "pushgateway"
  namespace = var.namespace
}