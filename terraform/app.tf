resource "kubernetes_deployment" "hello_world_deployment" {
  metadata {
    name = "spring-helloworld"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "spring-helloworld"
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = "spring-helloworld"
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
      app = "hello-world"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
