variable "namespace" {
  type    = string
  default = "monitoring"
}
variable "name" {
  type    = string
  default = "grafana"
}

variable "grafana_image" {
  type = string
}

variable "grafana_name" {
  type = string
}

variable "grafana_storage" {
  type = string
}

variable "github_container_registry_secret_name" {
  type = string
}
