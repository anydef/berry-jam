variable "namespace" {
  type = string
}

variable "storage" {
  type    = string
  default = "50Gi"
}

variable "nfs_path" {
  type    = string
  default = "/k3s/prometheus"
}

variable "nfs_server" {
  type    = string
  default = "192.168.178.51"
}

variable "name" {
  type = string
  default = "prometheus"
}

variable "context_path" {
  type = string
  default = "/prometheus"
}

variable "deployment_name" {
  type = string
}

variable "retention" {
  type = string
  default = "30d"
}