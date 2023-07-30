variable "project_id" {
  type    = string
}

variable "region" {
  default = "us-central1"
  type    = string
}

variable "zone" {
    type = string
    description = "Zone name"
    default = "us-central1-c"
}

