output "cluster_name" {
  value       = google_container_cluster.primary.name
  description = "The name of the GKE cluster"
}

output "host" {
  value = "https://${google_container_cluster.primary.endpoint}"
}

output "cluster_ca_certificate" {
  value = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

output "token" {
  value = data.google_client_config.default.access_token
}