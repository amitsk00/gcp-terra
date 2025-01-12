

variable "project_id" {
  type    = string
}

variable "region" {
  default = "us-central1"
  type    = string
}

variable "ar_repo_format_docker" {
  default = "DOCKER"
  type    = string
  
}

variable "py_image_1" {
  type        = string
  description = "Image for Python"
  default     = "python:3.8"
  
}