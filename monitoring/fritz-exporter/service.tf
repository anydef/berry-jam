resource "kubernetes_service_v1" "fritz-exporter" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = {
      "app.kubernetes.io/name" = var.name
      app                      = var.name
      name                     = var.name
    }

  }
  spec {
    selector = {
      app = var.name
    }
    port {
      name        = "http"
      protocol    = "TCP"
      port        = var.port
      target_port = var.port
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_ingress_v1" "pushgateway" {
  metadata {
    name        = var.name
    namespace   = var.namespace
    annotations = {
      "kubernetes.io/ingress.class"             = "traefik"
      "traefik.ingress.kubernetes.io/rule-type" = "PathPrefixStrip"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/${var.context_path}"
          backend {
            service {
              name = kubernetes_service_v1.fritz-exporter.metadata[0].name
              port { number = var.port }
            }
          }
        }

      }
    }

  }
}
