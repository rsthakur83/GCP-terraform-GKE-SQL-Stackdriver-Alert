resource "google_monitoring_alert_policy" "database_alert_policy" {
  display_name = "Database Alert Policies"
  combiner     = "OR"
  notification_channels = [google_monitoring_notification_channel.db_notify.id]
  conditions {
    display_name = "Cloud SQL Database - CPU utilization"
    condition_threshold {
      filter     = "metric.type=\"cloudsql.googleapis.com/database/cpu/utilization\" AND resource.type=\"cloudsql_database\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 0.8
      aggregations {
        alignment_period = "300s"
        per_series_aligner   = "ALIGN_MEAN"
        cross_series_reducer = "REDUCE_NONE"
      }
  }
 }



  conditions {
    display_name = "Cloud SQL Database - Memory usage"
    condition_threshold {
      filter     = "metric.type=\"cloudsql.googleapis.com/database/memory/usage\" AND resource.type=\"cloudsql_database\""
      duration   = "300s"
      comparison = "COMPARISON_GT"
      threshold_value = 7516192768 // In Gigabytes this values is equal to 7GB
      aggregations {
        alignment_period = "300s"
        per_series_aligner   = "ALIGN_MEAN"
        cross_series_reducer = "REDUCE_NONE"
      }
  }
 }


  conditions {
    display_name = "Cloud SQL Disk Usage"
    condition_threshold {
      filter     = "metric.type=\"cloudsql.googleapis.com/database/disk/bytes_used\" AND resource.type=\"cloudsql_database\""
      duration   = "300s"
      comparison = "COMPARISON_GT"
      threshold_value = 50737418240 // In Gigabytes this values is equal to 50GB
      aggregations {
        alignment_period = "300s"
        per_series_aligner   = "ALIGN_MEAN"
        cross_series_reducer = "REDUCE_NONE"
      }
  }
 }

  conditions {
    display_name = "Cloud SQL Uptime"
    condition_threshold {
      filter     = "metric.type=\"cloudsql.googleapis.com/database/up\" AND resource.type=\"cloudsql_database\""
      duration   = "300s"
      comparison = "COMPARISON_LT"
      threshold_value = 1
      aggregations {
        alignment_period = "120s"
        per_series_aligner   = "ALIGN_MEAN"
        cross_series_reducer = "REDUCE_NONE"
      }
  }
 }



  user_labels = {
    name = "databasealert"
  }
}


resource "google_monitoring_notification_channel" "db_notify" {
  display_name = "DB Email Notification Channel"
  type         = "email"
  labels = {
    email_address = var.notification
  }
}
