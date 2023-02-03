resource "kubernetes_secret_v1" "dockerconfigjson" {
  metadata {
    name      = var.github_container_registry_secret_name
    namespace = var.namespace
  }
  data = {
    ".dockerconfigjson" = "{\"auths\":{\"ghcr.io\":{\"auth\":\"${var.github_container_registry_secret_value}\"}}}"
  }
}