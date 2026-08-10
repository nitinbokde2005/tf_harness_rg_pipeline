output "resource_groups" {
  value       = azurerm_resource_group.this
  description = "Map of created resource group resources."
}

output "resource_group_names" {
  value       = { for k, v in azurerm_resource_group.this : k => v.name }
  description = "Map of created resource group names."
}

output "resource_group_ids" {
  value       = { for k, v in azurerm_resource_group.this : k => v.id }
  description = "Map of created resource group IDs."
}
