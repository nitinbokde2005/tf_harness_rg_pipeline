output "preprod_resource_groups" {
  value       = module.preprod_resource_groups.resource_group_names
  description = "Resource group names created for preprod environment."
}

output "prod_resource_groups" {
  value       = module.prod_resource_groups.resource_group_names
  description = "Resource group names created for prod environment."
}
