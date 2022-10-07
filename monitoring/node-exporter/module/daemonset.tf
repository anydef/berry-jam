resource "kubernetes_manifest" "daemonset_monitoring_node_exporter" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "DaemonSet"
    "metadata"   = {
      "labels" = {
        "app.kubernetes.io/component" = "exporter"
        "app.kubernetes.io/name"      = "node-exporter"
        "app.kubernetes.io/part-of"   = "kube-prometheus"
        "app.kubernetes.io/version"   = "2.4.2"
        "name"                        = "node-exporter"
        "app"                         = "node-exporter"
      }
      "name"      = "node-exporter"
      "namespace" = var.namespace
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/component" = "exporter"
          "app.kubernetes.io/name"      = "node-exporter"
          "app.kubernetes.io/part-of"   = "kube-prometheus"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app.kubernetes.io/component" = "exporter"
            "app.kubernetes.io/name"      = "node-exporter"
            "app.kubernetes.io/part-of"   = "kube-prometheus"
            "app.kubernetes.io/version"   = "2.4.2"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--path.sysfs=/host/sys",
                "--path.rootfs=/host/root",
                "--no-collector.wifi",
                "--no-collector.hwmon",
                "--collector.filesystem.ignored-mount-points=^/(dev|proc|sys|var/lib/docker/.+|var/lib/kubelet/pods/.+)($|/)",
                "--collector.netclass.ignored-devices=^(veth.*)$",
                "--collector.netdev.device-exclude=^(veth.*)$",
              ]
              "image" = "quay.io/prometheus/node-exporter:latest"
              "name"  = "node-exporter"
              "ports" = [
                {
                  "containerPort" = 9100
                  "protocol"      = "TCP"
                },
              ]
              "resources" = {
                "limits" = {
                  "cpu"    = "250m"
                  "memory" = "150Mi"
                }
                "requests" = {
                  "cpu"    = "102m"
                  "memory" = "150Mi"
                }
              }
              "volumeMounts" = [
                {
                  "mountPath"        = "/host/sys"
                  "mountPropagation" = "HostToContainer"
                  "name"             = "sys"
                  "readOnly"         = true
                },
                {
                  "mountPath"        = "/host/root"
                  "mountPropagation" = "HostToContainer"
                  "name"             = "root"
                  "readOnly"         = true
                },
              ]
            },
          ]
          "hostNetwork"  = true
          "hostPID"      = true
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          #          "securityContext" = {
          #            "runAsNonRoot" = true
          #            "runAsUser"    = 65534
          #          }
          #          "serviceAccountName" = "node-exporter"
          "tolerations" = [
            {
              "operator" = "Exists"
            },
          ]
          "volumes" = [
            {
              "hostPath" = {
                "path" = "/sys"
              }
              "name" = "sys"
            },
            {
              "hostPath" = {
                "path" = "/"
              }
              "name" = "root"
            },
          ]
        }
      }
      #      "updateStrategy" = {
      #        "rollingUpdate" = {
      #          "maxUnavailable" = "100%"
      #        }
      #        "type" = "RollingUpdate"
      #      }
    }
  }
}
