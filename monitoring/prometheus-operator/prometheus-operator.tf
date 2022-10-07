module "prometheus-operator" {
  source    = "./module"
  namespace = var.namespace
}