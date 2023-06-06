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
