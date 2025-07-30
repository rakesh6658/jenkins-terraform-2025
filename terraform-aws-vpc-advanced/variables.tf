variable "cidr_block" {
    
  
}
variable "enable_dns_hostnames" {
    default = true
  
}
variable "enable_dns_support" {
    default = true
  
}
variable "common_tags" {
    default = {}
  
}
variable "project_name" {
  
}
variable "vpc_tags" {
    default = {}
  
}
variable "public_subnet_cidrs" {
    type = list(string)
    validation {
        condition = length(var.public_subnet_cidrs) == 2
        error_message = "please enter two subnet cidrs"
      
    }  
}
variable "private_subnet_cidrs" {
    type = list(string)
    validation {
      condition = length(var.private_subnet_cidrs) == 2
      error_message = "please enter two subnet cidrs"
    }
  
}
variable "database_subnet_cidrs" {
    type = list(string)
    validation {
      condition = length(var.database_subnet_cidrs) == 2
      error_message = "please enter two database cidrs"
    }
  
}
variable "requestor_vpc_id" {
  
}
variable "is_peering_reuired" {
    default = false
  
}
variable "default_routable_id" {
  
}
variable "default_cidr_block" {
  
}