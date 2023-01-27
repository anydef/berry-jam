module "prometheus" {
  source = "git@github.com:anydef/tf-modules.git//prometheus"
  name = var.prometheus_cluster_monitoring_name
  context_path = "/${var.prometheus_cluster_monitoring_name}"
  namespace = var.namespace
  storage = var.prometheus_cluster_monitoring_storage
  volume_name = var.prometheus_cluster_monitoring_name
  deployment_name = var.prometheus_cluster_monitoring_name
  retention = "60d"
  service_monitor_selector_apps = var.service_monitor_selector_apps
  port = 9090
}