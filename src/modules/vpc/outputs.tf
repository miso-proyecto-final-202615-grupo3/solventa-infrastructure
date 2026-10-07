output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr" {
  value = aws_vpc.this.cidr_block
}

output "vpc_name" {
  value = aws_vpc.this.tags_all.Name
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_compute_subnet_ids" {
  value = aws_subnet.private_compute[*].id
}

output "private_database_subnet_ids" {
  value = aws_subnet.private_database[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.this.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.this.id
}
