variable "project_id" {
  type        = string
  description = "The project ID to host the cluster"
  default = "demogcp-demogcp-sandpit"
}

variable "region" {
  type        = string
  description = "The name of the cluster"
  default = "us-central1"
}

variable "vpc_network_name" {
 type = string
 description = "VPC network name"
 default = "demo-project-demogcp"
}

variable "vpc_subnetwork_name" {
 type = string
 description = "VPC Sub network name"
 default = "demo-project-demogcp-subnetwork"
}


variable "gke_cluster_name" {
 type = string
 description = "Cluster name"
 default = "demo-project-demogcp"
}

variable "logging_service" {
  description = "The logging service that the cluster should write logs to. Available options include logging.googleapis.com/kubernetes, logging.googleapis.com (legacy), and none"
  type        = string
  default     = "logging.googleapis.com/kubernetes"
}

variable "monitoring_service" {
  description = "The monitoring service that the cluster should write metrics to. Automatically send metrics from pods in the cluster to the Stackdriver Monitoring API. VM metrics will be collected by Google Compute Engine regardless of this setting. Available options include monitoring.googleapis.com/kubernetes, monitoring.googleapis.com (legacy), and none"
  type        = string
  default     = "monitoring.googleapis.com/kubernetes"
}

variable "bigquery_location" {
  type        = string
  description = "Location of BigQuery dataset"
  default = "US"
}

variable "dataset_name" {
  type        = string
  description = "BigQuery dataset Name"
  default = "demo_project_demogcp"
}
