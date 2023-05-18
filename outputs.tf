output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "igw" {
  description = "IGW ID"
  value       = aws_internet_gateway.igw
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.private
}

output "public_routetable" {
  description = "ID of public route table"
  value       = aws_route_table.public.id
}

output "private_routetable" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.private
}

output "nat_gateways" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.nat
}

