resource "kubernetes_deployment_v1" "grafana" {
  metadata {
    name      = "grafana"
    namespace = kubernetes_namespace.monitoring-namespace.id
  }
  spec {
    replicas = "1"
    selector {
      match_labels = {
        app : "grafana"
      }
    }
    template {
      metadata {
        name   = "grafana"
        labels = {
          app : "grafana"
        }
      }
      spec {

        container {
          name  = "grafana"
          image = "anydef/grafana:latest"
          port {
            container_port = 3000
            #            host_port      = 3000
          }
          resources {
            requests = {
              cpu    = "100m"
              memory = "250Mi"
            }
          }
          liveness_probe {
            http_get {
              path = "/grafana/api/health"
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
    name      = "grafana"
    namespace = kubernetes_namespace.monitoring-namespace.id
  }
  spec {
    selector = {
      app = "grafana"
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
    name        = "grafana"
    namespace   = kubernetes_namespace.monitoring-namespace.id
    annotations = {
      "kubernetes.io/ingress.class"             = "traefik"
      "traefik.ingress.kubernetes.io/rule-type" = "PathPrefixStrip"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/grafana"
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
