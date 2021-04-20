provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}


resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = "Kubernetes  Cluster Alert Policies"
  combiner     = "OR"
  notification_channels = [google_monitoring_notification_channel.default.id]
  conditions {
    display_name = "K8S Node CPU Usage"
    condition_threshold {
      filter     = "metric.type=\"kubernetes.io/node/cpu/allocatable_utilization\" AND resource.type=\"k8s_node\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = 1.5
      aggregations {
        alignment_period = "300s"
        per_series_aligner   = "ALIGN_MEAN"
        cross_series_reducer = "REDUCE_NONE"
      }
  }
 }

  conditions {
    display_name = "K8S Node Memory Usage"
    condition_threshold {
      filter     = "metric.type=\"kubernetes.io/node/memory/used_bytes\" AND resource.type=\"k8s_node\""
      duration   = "60s"
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
    display_name = "Pod Restart Count"
    condition_threshold {
      filter     = "metric.type=\"kubernetes.io/container/restart_count\" AND resource.type=\"k8s_container\""
      duration   = "120s"
      comparison = "COMPARISON_GT"
      threshold_value = 1
      aggregations {
        alignment_period = "120s"
        per_series_aligner   = "ALIGN_RATE"
        cross_series_reducer = "REDUCE_NONE"
      }
  }
 }

  conditions {
    display_name = "Container_network_receive_errors_total"
    condition_threshold {
      filter     = "metric.type=\"kubernetes.io/anthos/container_network_receive_errors_total\" AND resource.type=\"k8s_node\""
      duration   = "120s"
      comparison = "COMPARISON_GT"
      threshold_value = 4
      aggregations {
        alignment_period = "60s"
        per_series_aligner   = "ALIGN_RATE"
        cross_series_reducer = "REDUCE_NONE"
      }
  }
 }


  conditions {
    display_name = "Log Based Metrics Errors"
    condition_threshold {
      filter     = "metric.type=\"logging.googleapis.com/logs_based_metrics_error_count\" AND resource.type=\"k8s_node\""
      duration   = "300s"
      comparison = "COMPARISON_GT"
      threshold_value = 1
      aggregations {
        alignment_period = "60s"
        per_series_aligner   = "ALIGN_RATE"
        cross_series_reducer = "REDUCE_NONE"
      }
  }
 }


  conditions {
    display_name = "VM Instance Uptime"
    condition_threshold {
      filter     = "metric.type=\"compute.googleapis.com/guest/system/uptime\" AND resource.type=\"gce_instance\""
      duration   = "300s"
      comparison = "COMPARISON_LT"
      threshold_value = 1
      aggregations {
        alignment_period = "60s"
        per_series_aligner   = "ALIGN_COUNT"
        cross_series_reducer = "REDUCE_NONE"
      }
  }
 }


  user_labels = {
    name = "kubernetessalert"
  }
}

resource "google_monitoring_notification_channel" "default" {
  display_name = "K8S Email Notification Channel"
  type         = "email"
  labels = {
    email_address = var.notification
  }
}
