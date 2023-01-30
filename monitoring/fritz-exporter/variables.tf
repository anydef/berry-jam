variable "namespace" {
  type    = string
  default = "monitoring"
}

variable "name" {
  type    = string
  default = "fritz-exporter"
}

variable "fritz_hostname" {
  type    = string
  default = "fritz.box"
}
variable "fritz_username" {
  type = string
}
variable "fritz_password" {
  type = string
}
variable "port" {
  type    = number
  default = 9787
}

variable "context_path" {
  type    = string
  default = "/fritz-exporter"
}