# Time API Project

This project is a simple Time API built with Node.js and Express, deployed on Google Cloud Platform (GCP) using Terraform and Kubernetes.

## Features

- Provides current time information
- Deployed on GKE (Google Kubernetes Engine)
- CI/CD pipeline using GitHub Actions
- Infrastructure as Code with Terraform

## Tech Stack

- Backend: Node.js with Express
- Deployment: Docker, Kubernetes
- Cloud Provider: Google Cloud Platform
- IaC: Terraform
- CI/CD: GitHub Actions

## Project Structure

- `time_api/`: Contains the Node.js application
- `terraform/`: Terraform configuration for GCP resources
- `.github/workflows/`: CI/CD pipeline configuration

## Setup and Deployment

1. Set up GCP project and credentials
2. Configure Terraform variables in `terraform/terraform.tfvars`
3. Set up GitHub Secrets for GCP credentials and Docker Hub token
4. Push to the main branch to trigger the CI/CD pipeline

## Terraform

- The Terraform state file is stored remotely in a GCS bucket to enable collaboration and maintain state consistency.
- Module structure:
  - `modules/`: Contains reusable Terraform modules
    - `gke/`: Google Kubernetes Engine cluster configuration
    - `vpc/`: Virtual Private Cloud network setup
    - `gcs/`: Google Cloud Storage bucket for Terraform state
  - `main.tf`: Main Terraform configuration file
  - `variables.tf`: Input variables declaration
  - `outputs.tf`: Output values definition
  - `terraform.tfvars`: Variable values

## API Endpoint

The API provides a single endpoint:
GET /time

## Monitoring

Basic monitoring is set up using GCP's monitoring services.

## Local Development

To run the project locally:

1. Navigate to the `time_api` directory
2. Install dependencies: `npm install`
3. Start the server: `npm run nodemon`

### Happy Shipping!

