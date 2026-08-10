module "preprod_resource_groups" {
  source          = "./modules/resource_group"
  resource_groups = var.preprod_resource_groups
}

module "prod_resource_groups" {
  source          = "./modules/resource_group"
  resource_groups = var.prod_resource_groups
}
