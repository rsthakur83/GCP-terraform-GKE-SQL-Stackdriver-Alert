# Steps to setup monitoring for Kubernetes & Postgres database hosted on GCP using terraform

Follow below steps to configure monitoring for kubernetes & database in GCP using terraform:

Step1) Update the four variable values (project, region,zone, email) in variable.tf file as per the GCP project requirements. Here is the sample file variable.tf file content and same uplaoded in the repo.

```sh
variable "project" {
    description = "AWS region"
    default = "demogcp-demogcp-sandpit"
}

variable "region" {
    default = "us-east-1"
}

variable "zone" {
    default = "us-central1-c"
}

variable "notification" {
    default = "testgcp@sensysgatso.com"
}
```

Step2) Download terraform version 0.14.0 from the link <https://releases.hashicorp.com/terraform/0.14.0/terraform_0.14.0_linux_amd64.zip>

```sh
terraform init  # Initialize the plugins 
terraform plan  # To see the resources it will create on GCP
terraform apply # To deploy the K8S resources on GCP
```

Step3) Once the terraform apply finishes, we can see the alerting configured for k8s & all postgres databases in the GCP project.
