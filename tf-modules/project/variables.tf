variable "project_id" {
  type    = string
}

variable "region" {
  # default = "us-central1"
  type    = string
}

variable "topic" {
  # default = "activities"
  type    = string
}

variable "function" {
  # default = "pyPubTrig"
  type    = string
}

variable "function_sa" {
  # default = "plutosa"
  type    = string
}

variable "bucketsuffix" {
  # default = "-bucket"
  type    = string
}

variable "asset_list" {
    type = list(string)
    default = [
        "compute.googleapis.com/Instance",
        "compute.googleapis.com/Image",
        "compute.googleapis.com/Snapshot",
        "storage.googleapis.com/Bucket",
    ]
}

variable "asset_list_spanner" {
    type = list(string)
    default = [
        "spanner.googleapis.com/InstanceConfig" ,
        "spanner.googleapis.com/Instance" ,
        "spanner.googleapis.com/Database" ,
        "spanner.googleapis.com/Backup"
    ]
}






variable "service_list" {
    type = list(string)
    default = [
      "cloudasset.googleapis.com",
      "cloudbuild.googleapis.com",
      "cloudfunctions.googleapis.com",
      "containerregistry.googleapis.com",
      "cloudresourcemanager.googleapis.com",
      "iam.googleapis.com",
      "pubsub.googleapis.com",
      "sourcerepo.googleapis.com",
    ]
}

variable "default_service_list" {
    type = list(string)
    default = [
      "bigquery.googleapis.com",
      "bigquerymigration.googleapis.com",
      "bigquerystorage.googleapis.com",
      "cloudapis.googleapis.com",
      "clouddebugger.googleapis.com",
      "cloudtrace.googleapis.com",
      "logging.googleapis.com",
      "monitoring.googleapis.com",
      "servicemanagement.googleapis.com",
      "serviceusage.googleapis.com",
      "sql-component.googleapis.com",
      "storage.googleapis.com",
      "storage-api.googleapis.com",
      "storage-component.googleapis.com"
    ]
}