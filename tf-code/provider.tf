terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      # version = "~>4.0.0"
      version = "~> 4.51.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      # version = "~>4.0.0"
      version = "~> 4.51.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.7"
    }
  }
}



provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}
