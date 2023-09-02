
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