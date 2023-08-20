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


# variable "vpc_name_1" {
#     type = string
#     description = "Name of 1st VPC"
# }

variable "cidr1" {
    type    = string

}

variable "subnet_map" {
    description = "The list of subnet values"

    type = map(object({
     name = string ,
     cidr = string ,
     region = string
    }))

}


