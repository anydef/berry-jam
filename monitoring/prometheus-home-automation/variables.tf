variable "namespace" {
  type    = string
  default = "monitoring"
}

variable "prometheus_home_automation_name" {
  type    = string
  default = "prometheus"
}

variable "prometheus_home_automation_storage" {
  type = string
}

variable "prometheus_home_automation_location" {
  type = string
}

variable "nfs_server" {
  type = string
}

variable "service_monitor_selector_apps" {
  type = list(string)
  default = [
    "pushgateway"
  ]
}