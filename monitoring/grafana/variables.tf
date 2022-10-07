variable "namespace" {
  type    = string
  default = "monitoring"
}
variable "name" {
  type    = string
  default = "grafana"
}
variable "grafana_storage" {
  type = string
}

variable "grafana_nfs_path" {
  type = string
}

variable "nfs_server" {
  type = string
}

variable "grafana_image" {
  type = string
}