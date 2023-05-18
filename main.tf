data "aws_availability_zones" "available" {}

locals{
  azs      = slice(data.aws_availability_zones.available.names, 0, var.az_no)
  public_subnets_cidr = (var.public_subnets == []) ? [for k, v in local.azs : cidrsubnet(var.vpc_cidr_block, 4, k)] : var.public_subnets
  private_subnets_cidr = (var.private_subnets == []) ? [for k, v in local.azs : cidrsubnet(var.vpc_cidr_block, 4, k + 4 )] : var.private_subnets
}


resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}


# # # Public Subnets
# resource "aws_subnet" "public" {
#   count = length(local.azs)
#   vpc_id     = aws_vpc.vpc.id
#   cidr_block = element(local.public_subnets_cidr, count.index) 
#   availability_zone = element(local.azs, count.index)
#   tags = merge(
#     var.common_tags,
#     {
#     Name = "${var.vpc_name}-public-${element(local.azs, count.index)}"
#   }
#   )
# }

# ## Private Subnets
# resource "aws_subnet" "private" {
#   count = length(local.azs)
#   vpc_id     = aws_vpc.vpc.id
#   cidr_block = element(local.private_subnets_cidr, count.index) 
#   availability_zone = element(local.azs, count.index) 
#   tags = merge(
#     var.common_tags,
#     {
#     Name = "${var.vpc_name}-private-${element(local.azs, count.index)}"
#   }
#   )
# }

# ## Elastic IPs for NATs
# resource "aws_eip" "nat" {
#   count = (var.use_single_nat == false) ? length(aws_subnet.private[*].id) : 1
#   vpc = true
#   tags = {
#     Name = "${var.vpc_name}-${element(local.azs, count.index)}"
#   }  
# }

# ## NAT Gateways
# resource "aws_nat_gateway" "nat" {
#   depends_on    = [aws_internet_gateway.igw]
#   count         = (var.use_single_nat == false) ? length(aws_subnet.private[*].id) : 1
#   allocation_id = aws_eip.nat[count.index].id
#   subnet_id     = aws_subnet.public[count.index].id
#   tags = {
#     Name        = "${var.vpc_name}-${element(local.azs, count.index)}"
#   }
# }


# ########### Public Route Table  ###



# resource "aws_route_table" "public" {

#   vpc_id = aws_vpc.vpc.id
 
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   dynamic route {
#     for_each = var.public_routes
#     iterator = route
#     content {
#       cidr_block = lookup(route.value, "cidr_block", null)
#       ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)
#       egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null)
#       gateway_id = lookup(route.value, "gateway_id", null)
#       instance_id = lookup(route.value, "instance_id", null)
#       nat_gateway_id = lookup(route.value, "nat_gateway_id", null)
#       local_gateway_id = lookup(route.value, "local_gateway_id", null)
#       network_interface_id = lookup(route.value, "network_interface_id", null)
#       transit_gateway_id = lookup(route.value, "transit_gateway_id", null)
#       vpc_endpoint_id = lookup(route.value, "vpc_endpoint_id", null)
#       vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
#     }
#   }

#   dynamic route {
#     for_each = var.common_routes
#     iterator = route
#     content {
#       cidr_block = lookup(route.value, "cidr_block", null)
#       ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)
#       egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null)
#       gateway_id = lookup(route.value, "gateway_id", null)
#       instance_id = lookup(route.value, "instance_id", null)
#       nat_gateway_id = lookup(route.value, "nat_gateway_id", null)
#       local_gateway_id = lookup(route.value, "local_gateway_id", null)
#       network_interface_id = lookup(route.value, "network_interface_id", null)
#       transit_gateway_id = lookup(route.value, "transit_gateway_id", null)
#       vpc_endpoint_id = lookup(route.value, "vpc_endpoint_id", null)
#       vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
#     }
#   }
#     tags = {
#     Name        = "${var.vpc_name}-public"
#   }
# }

# resource "aws_route_table_association" "public_subnet_association" {
#   count = length(aws_subnet.public)
#   subnet_id = aws_subnet.public[count.index].id
#   route_table_id = aws_route_table.public.id
# }

# ##### Private Route Tables  ##################



# resource "aws_route_table" "private" {
#   count = length(aws_subnet.private)
#   vpc_id = aws_vpc.vpc.id
 
#   dynamic route {
#     for_each = var.private_routes
#     iterator = route
#     content {
#       cidr_block = lookup(route.value, "cidr_block", null)
#       ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)
#       egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null)
#       gateway_id = lookup(route.value, "gateway_id", null)
#       instance_id = lookup(route.value, "instance_id", null)
#       nat_gateway_id = lookup(route.value, "nat_gateway_id", null)
#       local_gateway_id = lookup(route.value, "local_gateway_id", null)
#       network_interface_id = lookup(route.value, "network_interface_id", null)
#       transit_gateway_id = lookup(route.value, "transit_gateway_id", null)
#       vpc_endpoint_id = lookup(route.value, "vpc_endpoint_id", null) 
#       vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
#     }
#   }

#   dynamic route {
#     for_each = var.common_routes
#     iterator = route
#     content {
#       cidr_block = lookup(route.value, "cidr_block", null)
#       ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)
#       egress_only_gateway_id = lookup(route.value, "egress_only_gateway_id", null)
#       gateway_id = lookup(route.value, "gateway_id", null)
#       instance_id = lookup(route.value, "instance_id", null)
#       nat_gateway_id = lookup(route.value, "nat_gateway_id", null)
#       local_gateway_id = lookup(route.value, "local_gateway_id", null)
#       network_interface_id = lookup(route.value, "network_interface_id", null)
#       transit_gateway_id = lookup(route.value, "transit_gateway_id", null)
#       vpc_endpoint_id = lookup(route.value, "vpc_endpoint_id", null)
#       vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
#     }
#   }

#   dynamic route {
#     for_each = (var.use_tgw == "yes") ? ["0.0.0.0/0"] : []
#     iterator = route
#     content {
#       cidr_block    = "0.0.0.0/0"
#       transit_gateway_id = var.it_tgw_id
#     }
#   }

#   dynamic route {
#     for_each = (var.use_tgw == "no") ? ["0.0.0.0/0"] : []
#     iterator = route
#     content {
#       cidr_block    = "0.0.0.0/0"
#       nat_gateway_id = (var.use_single_nat == false) ? aws_nat_gateway.nat[count.index].id : aws_nat_gateway.nat[0].id
#     }
#   }

#   tags = {
#     Name        = "${var.vpc_name}-private-${element(local.azs, count.index)}"
#   }  
# }

# # Associate Route Tables with Subnets

# resource "aws_route_table_association" "private_subnet_association" {
#   count = length(aws_subnet.private)
#   subnet_id = aws_subnet.private[count.index].id
#   route_table_id = aws_route_table.private[count.index].id
# }
