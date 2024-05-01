provider "kubernetes" {
  config_context_cluster   = "aws-cluster"
}

resource "kubernetes_namespace" "techchallenge" {
  metadata {
    name = "techchallenge"
  }
}

resource "kubernetes_deployment" "techchallenge" {
  metadata {
    name      = "techchallenge-app"
    namespace = kubernetes_namespace.example.metadata.0.name
    labels = {
      app = "techchallenge"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "techchallenge"
      }
    }

    template {
      metadata {
        labels = {
          app = "techchallenge"
        }
      }

      spec {
        container {
          image = "lucasgoleiro/techchallenge2:latest"  # Update with your DockerHub username and image name
          name  = "techchallenge-app"
        }
      }
    }
  }
}
