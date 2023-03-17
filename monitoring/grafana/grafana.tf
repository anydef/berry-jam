module "grafana" {
  source          = "git@github.com:anydef/tf-modules.git//grafana"
  name            = "grafana"
  namespace       = var.namespace
  grafana_storage = var.grafana_storage
  grafana_name    = var.grafana_name
  grafana_image   = "${var.grafana_image}:latest"
  github_container_registry_secret_name = var.github_container_registry_secret_name
}
