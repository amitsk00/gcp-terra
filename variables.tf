variable "project_id" { }

variable "credentials_file" { 
    default = "key.json"
}

variable "region" {
    type = string
    description = " Region name"
    default = "us-central1"
}

variable "zone" {
    type = string
    description = "Zone name"
    default = "us-central1-c"
}

