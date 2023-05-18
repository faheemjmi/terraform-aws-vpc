data "aws_availability_zones" "available" {}

locals{
  azs      = slice(data.aws_availability_zones.available.names, 0, var.az_no)
  public_subnets_cidr = (var.public_subnets == []) ? [for k, v in local.azs : cidrsubnet(var.vpc_cidr_block, 4, k)] : var.public_subnets
  private_subnets_cidr = (var.private_subnets == []) ? [for k, v in local.azs : cidrsubnet(var.vpc_cidr_block, 4, k + 4 )] : var.private_subnets
}