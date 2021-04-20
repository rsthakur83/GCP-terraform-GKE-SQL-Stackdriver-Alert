resource "google_compute_network" "network" {
  name = var.vpc_network_name
  auto_create_subnetworks = "false"
  routing_mode = "REGIONAL"
}



resource "google_compute_subnetwork"  "subnetwork" {
  name          = var.vpc_subnetwork_name
  ip_cidr_range = "10.128.16.0/20"
  region        = var.region
  network       = google_compute_network.network.name

  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = "10.132.0.0/14"
  }


  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = "10.131.16.0/20"
  }

}


resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = var.dataset_name
  friendly_name               = var.gke_cluster_name
  description                 = "BigQuery Dataset for GKE"
  location                    = var.bigquery_location
  default_table_expiration_ms = 3600000

  labels = {
    env = "prod"
  }

}

resource "google_container_cluster" "gkecluster" {
  provider = google-beta
  project  = var.project_id
  name     = var.gke_cluster_name
  location = var.region
  network  = google_compute_network.network.name
  subnetwork = google_compute_subnetwork.subnetwork.name
  logging_service    = var.logging_service
  monitoring_service = var.monitoring_service
  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }


  depends_on = [
    google_bigquery_dataset.dataset
  ]

resource_usage_export_config {
  enable_network_egress_metering = false
  enable_resource_consumption_metering = true
  bigquery_destination {
    dataset_id = google_bigquery_dataset.dataset.dataset_id
  }
}
  


 addons_config {
  http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
    gce_persistent_disk_csi_driver_config  {
        enabled = true
    }
  }


  remove_default_node_pool = true
  initial_node_count = 1
  resource_labels = {
    environment = "prod"
  }

master_auth {
  client_certificate_config {
    issue_client_certificate = false
  }
}

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

}


resource "google_container_node_pool" "node_pool" {
  provider = google-beta
  name     = "main-pool"
  project  = var.project_id
  location = var.region
  cluster  = var.gke_cluster_name



  initial_node_count = "1"



  autoscaling {
    min_node_count = "1"
    max_node_count = "5"
  }

  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  node_config {
    image_type   = "COS"
    machine_type = "e2-standard-4"

    labels = {
      env = "prod"
    }


    disk_size_gb = "30"
    disk_type    = "pd-standard"
    preemptible  = false



    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  lifecycle {
    ignore_changes = [initial_node_count]
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}
