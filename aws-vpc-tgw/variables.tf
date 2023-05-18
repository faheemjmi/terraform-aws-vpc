# VPC Input Variables
variable "aws_region" {}
# VPC Name
variable "vpc_name" {}
variable az_no {
    default = 3
}
variable  "use_single_nat" {
     default = false
}
variable "vpc_cidr_block" {}
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