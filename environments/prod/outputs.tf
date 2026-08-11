output "prod_resource_groups" {
  value       = module.resource_group.resource_group_names
  description = "Resource group names created for prod environment."
}

output "prod_resource_group_ids" {
  value       = module.resource_group.resource_group_ids
  description = "Resource group IDs created for prod environment."
}
