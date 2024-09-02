# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Set up the Terraform backend to store state in Google Cloud Storage
terraform {
  backend "gcs" {
    bucket = "time_api_bucket"
    prefix = "terraform/state"
  }
}

# Create the network infrastructure
module "network" {
  source      = "./modules/network"
  project_id  = var.project_id
  region      = var.region
}

# Set up the Google Kubernetes Engine (GKE) cluster
module "gke" {
  source       = "./modules/gke"
  network_name = module.network.vpc_name
  subnet_name  = module.network.subnet_name
  project_id   = var.project_id
  region       = var.region
}

# Configure Kubernetes resources within the GKE cluster
module "k8s" {
  source                 = "./modules/k8s"
  host                   = module.gke.host
  cluster_ca_certificate = module.gke.cluster_ca_certificate
  token                  = module.gke.token
}

# Set up monitoring for the API
module "monitoring" {
  source            = "./modules/monitoring"
  api_host          = module.k8s.load_balancer_ip
}


