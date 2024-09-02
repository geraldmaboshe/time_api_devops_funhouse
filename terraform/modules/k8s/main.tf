# Kubernetes provider configuration
provider "kubernetes" {
  host                   = var.host
  cluster_ca_certificate = var.cluster_ca_certificate
  token                  = var.token
}

# Create a Kubernetes namespace for the time-api
resource "kubernetes_namespace" "time_api" {
  metadata {
    name = "time-api"
  }
}

# Deploy the time-api application
resource "kubernetes_deployment" "time_api" {
  metadata {
    name      = "time-api"
    namespace = kubernetes_namespace.time_api.metadata[0].name
  }

  spec {
    replicas = 1  # Number of pod replicas

    selector {
      match_labels = {
        app = "time-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "time-api"
        }
      }

      spec {
        container {
          image = "${var.image_url}"  # Docker image for the time-api
          name  = "time-api"

          port {
            container_port = 3000  # Port the container listens on
          }
        }
      }
    }
  }
}

# Create a Kubernetes service to expose the time-api
resource "kubernetes_service" "time_api" {
  metadata {
    name      = "time-api"
    namespace = kubernetes_namespace.time_api.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment.time_api.spec[0].template[0].metadata[0].labels.app
    }

    port {
      port        = 80   # Port the service listens on
      target_port = 3000 # Port to forward to on the pod
    }

    type = "LoadBalancer"  # Exposes the service externally using a cloud provider's load balancer
  }
}