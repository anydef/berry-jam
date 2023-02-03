variable "namespace" {
  type    = string
  default = "monitoring"
}

variable "github_container_registry_secret_value" {
  type = string
}
variable "github_container_registry_secret_name" {
  type = string
}