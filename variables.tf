# VPC Input Variables
variable "aws_region" {
    type = string
    default = "us-east-1"
 }
# VPC Name
variable "vpc_name" {
    type = string
    default = ""
}

variable "vpc_cidr_block" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
  default     = "10.0.0.0/16"
}

variable az_no {
    type = number
    default = 3
}
variable  "use_single_nat" {
     default = false
}

variable  "use_tgw" {
    default = "no"
}
variable "it_tgw_id" {
     default = ""
}
variable "transit_cidr_blocks" {
    default = ""
}
variable common_tags {
    default = ""
}

variable  "public_subnets" {
     default = []
}
variable  "private_subnets" {
     default = []
}
variable "public_routes" {
    default = []
}
variable "private_routes" {
    default = []
}
variable "common_routes" {
    default = []
}