variable "host" {
  description = "The URL of the Kubernetes API server"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "The base64 encoded CA certificate for the Kubernetes cluster"
  type        = string
}

variable "token" {
  description = "The authentication token for the Kubernetes API server"
  type        = string
}

variable "image_url" {
  description = "The URL of the container image"
  type        = string
  default     = "geraldmaboshe/time-api:latest"
}