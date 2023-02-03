variable "namespace" {
  type    = string
  default = "monitoring"
}

variable "name" {
  type    = string
  default = "viessmann-exporter"
}

variable "viessmann_api_key" {
  type = string
}
variable "viessmann_email" {
  type = string
}
variable "viessmann_password" {
  type = string
}

variable "github_container_registry_secret_name" {
  type = string
}