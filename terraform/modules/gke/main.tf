# Create the primary GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  location = var.region

  # Remove the default node pool and create a custom one
  remove_default_node_pool = true
  initial_node_count       = 1

  # Set the network and subnetwork for the cluster
  network    = var.network_name
  subnetwork = var.subnet_name
}

# Create a custom node pool for the GKE cluster
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  # Configure autoscaling for the node pool
  autoscaling {
    min_node_count = 1
    max_node_count = terraform.workspace == "prod" ? 10 : 3
  }

  # Configure the nodes in the pool
  node_config {
    # Set OAuth scopes for the nodes
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    # Add labels to the nodes
    labels = {
      env = var.project_id
    }

    # Set machine type based on the workspace (production or non-production)
    machine_type = terraform.workspace == "prod" ? "e2-standard-2" : "e2-micro"
    
    # Add tags to the nodes
    tags = ["gke-node", "${var.project_id}-gke"]
    
    # Disable legacy metadata endpoints
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}

# Retrieve the default Google Client configuration
data "google_client_config" "default" {}