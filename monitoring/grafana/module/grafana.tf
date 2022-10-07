resource "kubernetes_deployment_v1" "grafana" {
  metadata {
    name      = var.name
    namespace = var.namespace
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
          app : var.name
        }
      }
      spec {

        container {
          name  = var.name
          image = var.grafana_image
          port {
            container_port = 3000
          }
          resources {
            requests = {
              cpu    = "100m"
              memory = "200Mi"
            }
          }
          liveness_probe {
            http_get {
              path = "/${var.context_path}/api/health"
              port = 3000
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
          volume_mount {
            mount_path = "/var/lib/grafana"
            name       = "grafana-storage"
          }
        }
        volume {
          name = "grafana-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim_v1.grafana.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "grafana" {
  metadata {
    name      = var.name
    namespace =var.namespace
  }
  spec {
    selector = {
      app = var.name
    }
    port {
      port        = 3000
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_ingress_v1" "grafana" {
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
              name = kubernetes_service_v1.grafana.metadata[0].name
              port { number = 3000 }
            }
          }
        }

      }
    }

  }
}
