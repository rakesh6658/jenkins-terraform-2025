output "vpc" {
    value = module.main.vpc_id
  
}
output "azs" {
    value = module.main.availability_zones
  
}
output "public_subnet_ids" {
    value = module.main.public_subnet_ids
  
}
output "private_subnet_ids" {
    value = module.main.private_subnet_ids
  
}
output "database_subnet_ids" {
    value = module.main.database_subnet_ids
  
}

