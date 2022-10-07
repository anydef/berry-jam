resource "kubernetes_deployment_v1" "pushgateway" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = {
      app : var.name
      name : var.name
    }
  }
  spec {
    replicas = "1"
    selector {
      match_labels = {
        app : var.name
      }
    }
    template {
      metadata {
        name   = var.name
        labels = {
          "app.kubernetes.io/name" = var.name
          app                    = var.name
          name                   = var.name
        }
      }
      spec {
        container {
          name  = var.name
          image = var.image
          port {
            name           = "http"
            container_port = 9091
          }
          resources {
            requests = {
              cpu    = "50m"
              memory = "100Mi"
            }
          }
          liveness_probe {
            http_get {
              path = "/"
              port = 9091
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "pushgateway" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = {
      "app.kubernetes.io/name" = var.name
      app                    = var.name
      name                   = var.name
    }
  }
  spec {
    selector = {
      app = var.name
    }
    port {
      name        = "http"
      protocol    = "TCP"
      port        = 9091
      target_port = 9091
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
              name = kubernetes_service_v1.pushgateway.metadata[0].name
              port { number = 9091 }
            }
          }
        }

      }
    }

  }
}
