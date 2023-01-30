
resource "kubernetes_deployment_v1" "fritz-exporter" {
  metadata {
    name = var.name
    namespace = var.namespace
    labels = {
      app: var.name
      name: var.name
    }
  }
  spec {
    replicas = "1"
    selector {
      match_labels = {
        app: var.name
      }
    }
    template {
      metadata {
        name   = var.name
        labels = {
          "app.kubernetes.io/name" = var.name
          app                      = var.name
          name                     = var.name
        }
      }
      spec {
        container {
          name = var.name
          image = "pdreker/fritz_exporter:2"
          port {
            container_port = var.port
          }
          env {
            name = "FRITZ_HOSTNAME"
            value = var.fritz_hostname
          }
          env {
            name = "FRITZ_USERNAME"
            value = var.fritz_username
          }
          env {
            name = "FRITZ_PASSWORD"
            value = var.fritz_password
          }
        }
      }
    }
  }
}