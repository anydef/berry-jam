variable "namespace" {
  type    = string
  default = "monitoring"
}

variable "name" {
  type    = string
  default = "prometheus"
}

variable "prometheus_storage" {
  type = string
}

variable "prometheus_nfs_path" {
  type = string
}

variable "nfs_server" {
  type = string
}
