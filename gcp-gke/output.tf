output "name" {
  description = "The name of the cluster master"
  value = google_container_cluster.gkecluster.name
}

output "master_version" {
  description = "The Kubernetes master version."
  value       = google_container_cluster.gkecluster.master_version
}

output "endpoint" {
  description = "The IP address of the cluster master."
  sensitive   = false
  value       = google_container_cluster.gkecluster.endpoint
}


output "cluster_ca_certificate" {
  description = "The public certificate that is the root of trust for the cluster."
  value       = base64decode(google_container_cluster.gkecluster.master_auth[0].cluster_ca_certificate)
}
