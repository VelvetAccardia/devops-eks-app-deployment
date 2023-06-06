resource "kubernetes_deployment" "hello_world_deployment" {
  metadata {
    name = "spring-helloworld"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "spring-hello-world"
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = "spring-hello-world"
        }
      }

      spec {
        container {
          image = "velvetaccardia/spring-helloworld"
          name  = "hello-world"

          port {
            name           = "tcp"
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "hello_world_svc" {
  metadata {
    name = "hello-world"
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = "spring-helloworld"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
