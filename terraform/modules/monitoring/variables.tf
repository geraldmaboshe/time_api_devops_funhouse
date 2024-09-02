
variable "api_host" {
  description = "The host of the API to monitor"
  type        = string
}


variable "notification_email" {
  description = "The email address for notifications"
  type        = string
  default     = "maboshegerald1@gmail.com"
}
