output "vpc_id" {
    value = aws_vpc.this.id
  
}
output "availability_zones" {
    value = local.azs
}
output "public_subnet_ids" {
    value = aws_subnet.public[*].id
  

}
output "private_subnet_ids" {
    value = aws_subnet.private[*].id
  
}
output "database_subnet_ids" {
    value = aws_subnet.database[*].id
  
}