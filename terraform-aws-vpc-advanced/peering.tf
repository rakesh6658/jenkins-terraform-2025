resource "aws_vpc_peering_connection" "peering" {
  count = var.is_peering_reuired ? 1 : 0
  peer_vpc_id   = aws_vpc.this.id
  #requestor
  vpc_id        = var.requestor_vpc_id
   auto_accept   = true
   tags = merge(var.common_tags,
   {
    Name = var.project_name
   }
   )
}
resource "aws_route" "default_peering" {
    count = var.is_peering_reuired ? 1 : 0
  route_table_id            = var.default_routable_id
  destination_cidr_block    = var.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
  
}
resource "aws_route" "public_peering" {
    count = var.is_peering_reuired ? 1 : 0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = var.default_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
  
}
resource "aws_route" "private_peering" {
    count = var.is_peering_reuired ? 1 : 0
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = var.default_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
  
}
resource "aws_route" "database_peering" {
    count = var.is_peering_reuired ? 1 : 0
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = var.default_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
  
}