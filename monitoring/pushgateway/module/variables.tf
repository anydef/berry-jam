variable "namespace" {
  type = string
}

variable "name" {
  type = string
}
variable "image" {
  type    = string
  default = "prom/pushgateway"
}

variable "context_path" {
  type = string
  default = "/pushgateway"
}