module "prometheus" {
  source = "git@github.com:anydef/tf-modules.git//prometheus"
  name = var.prometheus_home_automation_name
  context_path = "/${var.prometheus_home_automation_name}"
  namespace = var.namespace
  storage = var.prometheus_home_automation_storage
  volume_name = var.prometheus_home_automation_name
  deployment_name = var.prometheus_home_automation_name
  retention = "999d"
  service_monitor_selector_apps = var.service_monitor_selector_apps
  port = 9092
}