module "prometheus-operator" {
  source    = "git@github.com:anydef/tf-modules.git//prometheus-operator"
  namespace = var.namespace
}