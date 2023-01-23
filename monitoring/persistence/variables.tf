variable "grafana_name" {
  type    = string
  default = "grafana"
}
variable "grafana_location" {
  type    = string
  default = "grafana"
}
variable "grafana_storage" {
  type = string
}

variable "prometheus_cluster_monitoring_name" {
  type = string
}
variable "prometheus_cluster_monitoring_storage" {
  type = string
}
variable "prometheus_cluster_monitoring_location" {
  type = string
}

variable "prometheus_home_automation_name" {
  type = string
}
variable "prometheus_home_automation_storage" {
  type = string
}
variable "prometheus_home_automation_location" {
  type = string
}

variable "nfs_path" {
  type = string
}
variable "nfs_server" {
  type = string
}
