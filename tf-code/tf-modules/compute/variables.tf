

variable module_enabled {
  description = ""
  default     = true
}

variable "project_id" { }

variable "region" {
    type = string
    description = " Region name"
}

variable "zone" {
    type = string
    description = "Zone name"
}




variable "mac_type_e2m" {
    type = string
    description = "VM's machine type"
}

variable "vm_name" {
    type = string
    description = "Name of the VM"
}

variable "vm_image" {
    type = string
    description = "Image for VM"
  
}

variable "startup_url" {
  description = "The GCS URI to be used for startup"
  type        = string
}

# variable "vpc_name" {
#     type = string
# }

variable "subnet_name" {
    type = string
}

variable "sa_mail" {
    type = string
    description = "SA for VM"
}

variable "sa_list" {
    type = list(string)
}



## Autoscalar



variable autoscaling {
  description = "Enable autoscaling."
  default     = false
}

variable max_replicas {
  description = "Autoscaling, max replicas."
  default     = 4
}

variable min_replicas {
  description = "Autoscaling, min replics."
  default     = 1
}

variable cooldown_period {
  description = "Autoscaling, cooldown period in seconds."
  default     = 60
}

variable autoscaling_cpu {
  description = "Autoscaling, cpu utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#cpu_utilization"
  type        = number
  default     = 0.5
}

variable autoscaling_metric {
  description = "Autoscaling, metric policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#metric"
  type        = list
  default     = []
}

variable autoscaling_lb {
  description = "Autoscaling, load balancing utilization policy block as single element array. https://www.terraform.io/docs/providers/google/r/compute_autoscaler.html#load_balancing_utilization"
  type        = list
  default     = []
}

variable distribution_policy_zones {
  description = "The distribution policy for this managed instance group when zonal=false. Default is all zones in given region."
  type        = list
  default     = []
}

variable mac_type_f1m {
  description = "Machine type for the VMs in the instance group."
  default     = "f1-micro"
}

variable "preemptible" {
  description = "Use preemptible instances - lower price but short-lived instances. See https://cloud.google.com/compute/docs/instances/preemptible for more details"
  default     = "false"
}

variable "automatic_restart" {
  description = "Automatically restart the instance if terminated by GCP - Set to false if using preemptible instances"
  default     = "true"
}

variable "sa_email_list" {
    description = "mail List of SA created"
    default = " "
}
