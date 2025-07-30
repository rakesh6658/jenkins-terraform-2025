locals {
  vpc_id = module.main.vpc_id
  public_subnet_ids = module.main.public_subnet_ids
  private_subnet_ids = module.main.private_subnet_ids
  database_subnet_ids = module.main.database_subnet_ids
  

}