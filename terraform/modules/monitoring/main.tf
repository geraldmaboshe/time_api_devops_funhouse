# Email notification channel for alerts
resource "google_monitoring_notification_channel" "email" {
  display_name = "Email Notification Channel"
  type         = "email"
  labels = {
    email_address = var.notification_email
  }
}

# Uptime check configuration for the API
resource "google_monitoring_uptime_check_config" "api_uptime_check" {
  display_name = "API Uptime Check"
  timeout      = "10s"
  period       = "60s"

  # HTTP check configuration
  http_check {
    path = "/health"
    port = 80
  }

  # Resource to monitor
  monitored_resource {
    type   = "uptime_url"
    labels = {
      host = var.api_host
    }
  }
}

# Alert policy for API uptime
resource "google_monitoring_alert_policy" "api_alert_policy" {
  display_name = "API Alert Policy"
  combiner     = "OR"

  # Alert condition
  conditions {
    display_name = "Uptime Check Failed"
    condition_threshold {
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND resource.type=\"uptime_url\""
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 1

      # Aggregation settings
      aggregations {
        alignment_period     = "300s"
        per_series_aligner   = "ALIGN_NEXT_OLDER"  
        cross_series_reducer = "REDUCE_COUNT_FALSE" 
      }
    }
  }

  # Link to the notification channel
  notification_channels = [google_monitoring_notification_channel.email.id]
}
