terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0 "
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }
  }
}

resource "helm_release" "hello_world" {
  name      = "helloworld-spring"
  namespace = "core"
  chart     = "./../../../helm/helloworld-spring"
}
