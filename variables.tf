# VPC Input Variables
variable "aws_region" {
    description = "aws region"
    type = string
    default = "us-east-1"
 }
# VPC Name
variable "vpc_name" {
    description = "vpc name"
    type = string
    default = ""
}

variable "vpc_cidr_block" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
  default     = "10.0.0.0/16"
}

variable az_no {
    description = "number of availability zones"
    type = number
    default = 3
}
variable  "use_single_nat" {
     description = "To use single NAT"
     default = false
}

variable  "use_tgw" {
    description = "Enable TGW Routing"
    default = "no"
}
variable "it_tgw_id" {
    description = "TGW ID"
     default = ""
}
variable "transit_cidr_blocks" {
    description = "TGW CIDRs"
    default = ""
}
variable common_tags {
    description = "Common Tags"
    default = {}
}

variable  "public_subnets" {
     description = "public subnets"
     default = []
}
variable  "private_subnets" {
     description = "privae subnets"
     default = []
}
variable "public_routes" {
    description = "publc routes"
    default = []
}
variable "private_routes" {
    description = "private routes"
    default = []
}
variable "common_routes" {
    description = "common routes"
    default = []
}
