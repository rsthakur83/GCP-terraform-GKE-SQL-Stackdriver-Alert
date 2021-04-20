# Steps to setup PostgreSQL Database on GCP using Terraform

Follow below steps to deploy PostgreSQL in GCP using terraform.

**Step 1)**  
Change below 5 default values such as `project_id, name, tier, region, database_version, zone` in the variable.tf file as per the new GCP or existing GCP project.

```sh
variable "project_id" {
  description = "The project ID to manage the Cloud SQL resources"
  type        = string
  default     = "demogcp-demogcp-sandpit"
}

variable "name" {
  type        = string
  description = "The name of the Cloud SQL resources"
  default     = "demo-demogcp-testgcp-db3"
}

variable "tier" {
  description = "The tier for the master instance."
  type        = string
  default     = "db-custom-1-3840"
}

variable "region" {
  description = "The region of the Cloud SQL resources"
  type        = string
  default     = "us-central1"
}


variable "database_version" {
  description = "The database version to use"
  type        = string
  default     = "POSTGRES_13"
}


variable "zone" {
  description = "The zone for the master instance, it should be something like: `us-central1-a`, `us-east1-c`."
  type        = string
  default     = "us-central1-a"
}
```

**Note:** Update the variable.tf file section **(Line number 133 for database & 204 for users)** with more databases, users if we need some additional databases and their users.

**Step 2)**
 Download terraform version 0.14.0 from the link <https://releases.hashicorp.com/terraform/0.14.0/terraform_0.14.0_linux_amd64.zip>

```sh
terraform init  # Initialize the plugins 
terraform plan  # To see the resources it will create on GCP
terraform apply # To deploy the K8S resources on GCP
```

**Step 3)**
After Terraform apply finishes we can see the GCP below output.Terraform take cares of all required resources, configuration required to setup production ready database. From the GCP console we can reset the username, password for each database such as `testgcp_ams, testgcp_dvom, testgcp_shs,testgcp_sds`etc..We can create, add more databases user from console if in case we missed something during terraform apply command.

```sh
Database_Name = "demo-demogcp-testgcp-db3"
Database_Version = "POSTGRES_13"
```
