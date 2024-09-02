variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
  default     = "euphoric-diode-434310-v4"
}

variable "region" {
  description = "The region to deploy resources to"
  type        = string
  default     = "us-central1"
}