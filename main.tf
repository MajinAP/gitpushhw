terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.25.0"
    }
  }
}

provider "google" {
  # Configuration options
project = "banesrevenge"
region = "us-east-2"
zone = "us-east-2a"
credentials = "banesrevenge-e53d51e332c9.json"
}

resource "google_storage_bucket" "the_anthem_bucket" {
  name          = "now_you_a_single_mom"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_compute_network" "gitpush_vpc" {
  auto_create_subnetworks = false
  description             = "testing gcp terraform code in vscode"
  mtu                     = 1460
  name                    = "gitpush-vpc"
  project                 = "banesrevenge"
  routing_mode            = "REGIONAL"
}
# terraform import google_compute_network.gitpush_vpc projects/banesrevenge/global/networks/gitpush-vpc



#resource "google_compute_network" "custom-vpc-tf" {
  #name = "custom-vpc-tf"
 #auto_create_subnetworks = false
#}

resource "google_compute_subnetwork" "gitpush_subnet" {
  ip_cidr_range = "10.233.1.0/24"

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

  name                       = "gitpush-subnet"
  network                    = "https://www.googleapis.com/compute/v1/projects/banesrevenge/global/networks/gitpush-vpc"
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  project                    = "banesrevenge"
  purpose                    = "PRIVATE"
  region                     = "asia-northeast1"
  stack_type                 = "IPV4_ONLY"
}
# terraform import google_compute_subnetwork.gitpush_subnet projects/banesrevenge/regions/asia-northeast1/subnetworks/gitpush-subnet


output "auto" {
  value = google_compute_network.auto-vpc-tf.id
}

#output "custom" {
#  value = google_compute_network.custom-vpc-tf.id
#}

