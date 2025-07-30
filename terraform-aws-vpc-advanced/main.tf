resource "aws_vpc" "this" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = var.enable_dns_hostnames
    enable_dns_support = var.enable_dns_support
    tags = merge(var.common_tags,
    {
        Name = var.project_name
    },var.vpc_tags
    )
  
}
resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id
    tags = merge(var.common_tags,{
        Name = var.project_name
    }
    )

  
}
resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.this.id
    map_public_ip_on_launch = true
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = local.azs[count.index]
    tags = merge(
        var.common_tags,
        {
            Name = "${var.project_name}-public-${local.azs[count.index]}"
        }
    )
    
  
}
resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.this.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = local.azs[count.index]
    tags = merge(
        var.common_tags,
        {
            Name = "${var.project_name}-private-${local.azs[count.index]}"
        }
    )
  
}
resource "aws_subnet" "database" {
count = length(var.database_subnet_cidrs)
vpc_id = aws_vpc.this.id
cidr_block = var.database_subnet_cidrs[count.index]
availability_zone = local.azs[count.index]
tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-database-${local.azs[count.index]}"
    }

)
  
}
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id
    
    tags = merge(var.common_tags,{
        Name = "${var.project_name}-public"
    })  
}
resource "aws_route" "public_rote" {
    
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
  
}
resource "aws_eip" "my_eip" {
domain = "vpc"
  
}
resource "aws_nat_gateway" "my_nat_ip" {
    subnet_id = aws_subnet.public[0].id
    allocation_id = aws_eip.my_eip.id
    tags = {
      Name = var.project_name
    }
    depends_on = [ aws_internet_gateway.this ]
  
}
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.this.id
    
    tags = merge(var.common_tags,{
        Name = "${var.project_name}-private"
    })  
}
resource "aws_route" "private_route" {
    
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.my_nat_ip.id
  
}
resource "aws_route_table" "database" {
    vpc_id = aws_vpc.this.id
    
    tags = merge(var.common_tags,{
        Name = "${var.project_name}-database"
    })  
}
resource "aws_route" "database_route" {
    
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.my_nat_ip.id
  
}

resource "aws_route_table_association" "public" {
    count = length(var.public_subnet_cidrs)

    subnet_id = element(aws_subnet.public[*].id,count.index)
    route_table_id = aws_route_table.public.id
  
}
resource "aws_route_table_association" "private" {
    count = length(var.private_subnet_cidrs)

    subnet_id = element(aws_subnet.private[*].id,count.index)
    route_table_id = aws_route_table.private.id
  
}
resource "aws_route_table_association" "database" {
    count = length(var.database_subnet_cidrs)

    subnet_id = element(aws_subnet.database[*].id,count.index)
    route_table_id = aws_route_table.database.id
  
}

