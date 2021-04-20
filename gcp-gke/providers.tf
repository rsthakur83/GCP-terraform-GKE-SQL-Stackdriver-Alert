provider "google" {
  project = var.project_id
  region  = var.region
  credentials = file("../demogcp-demogcp-sandpit-c3b8db7b04c6.json")
}

