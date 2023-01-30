variable "namespace" {
  type    = string
  default = "monitoring"
}

variable "prometheus_cluster_monitoring_name" {
  type    = string
  default = "prometheus"
}

variable "prometheus_cluster_monitoring_storage" {
  type = string
}

variable "prometheus_cluster_monitoring_location" {
  type = string
}

variable "nfs_server" {
  type = string
}

variable "service_monitor_selector_apps" {
  type = list(string)
  default = [
    "kube-state-metrics",
    "node-exporter",
    "kubelet",
    "traefik",
    "fritz-exporter",
  ]
}