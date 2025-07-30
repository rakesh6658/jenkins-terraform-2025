module "main" {
    source = "../../terraform-aws-vpc-advanced"
    cidr_block = var.cidr_block
    project_name = var.project_name
   common_tags = var.common_tags
   #public subnet
   public_subnet_cidrs = var.public_subnet_cidrs
   # private_subnet
   private_subnet_cidrs = var.private_subnet_cidrs
   # database_subnet
   database_subnet_cidrs = var.database_subnet_cidrs
   #public route table 
   requestor_vpc_id = data.aws_vpc.default.id
   default_cidr_block = data.aws_vpc.default.cidr_block
   default_routable_id = data.aws_vpc.default.main_route_table_id
is_peering_reuired = true
   

  
}