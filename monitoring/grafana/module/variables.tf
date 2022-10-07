variable "namespace" {
  type = string
}

variable "storage" {
  type    = string
}

variable "nfs_path" {
  type    = string
}

variable "nfs_server" {
  type    = string
}

variable "name" {
  type = string
}
variable "grafana_image" {
  type    = string
}
variable "context_path" {
  type = string
  default = "/grafana"
}