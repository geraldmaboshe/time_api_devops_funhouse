output "load_balancer_ip" {
  value       = module.k8s.load_balancer_ip
  description = "The external IP address of the LoadBalancer for the time-api service"
}