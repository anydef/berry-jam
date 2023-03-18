resource "kubernetes_secret_v1" "dockerconfigjson" {
  metadata {
    name      = var.github_container_registry_secret_name
    namespace = var.namespace
  }
  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "ghcr.io" = {
          auth  = base64encode(var.github_container_registry_secret_value)
        }
      }
    })
  }
}

