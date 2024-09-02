output "load_balancer_ip" {
  value       = kubernetes_service.time_api.status[0].load_balancer[0].ingress[0].ip
  description = "The external IP address of the LoadBalancer for the time-api service"
}