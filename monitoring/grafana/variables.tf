variable "namespace" {
  type    = string
  default = "monitoring"
}
variable "name" {
  type    = string
  default = "grafana"
}
variable "storage" {
  type = string
}

variable "nfs_path" {
  type = string
}

variable "nfs_server" {
  type = string
}

variable "image" {
  type = string
}