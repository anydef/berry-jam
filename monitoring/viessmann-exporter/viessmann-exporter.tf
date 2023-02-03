module "viessmann-exporter" {
  source                                = "git@github.com:anydef/viessmann-exporter.git//tf_module"
  namespace                             = var.namespace
  github_container_registry_secret_name = var.github_container_registry_secret_name
  port                                  = 5000
  viessmann_exporter_image              = "ghcr.io/anydef/viessmann-exporter:latest"
  viessmann_api_key                     = var.viessmann_api_key
  viessmann_email                       = var.viessmann_email
  viessmann_password                    = var.viessmann_password
  viessmann_polling_interval            = 90
}