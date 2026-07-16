output "netapp_accounts_id" {
  description = "Map of id values across all netapp_accounts, keyed the same as var.netapp_accounts"
  value       = { for k, v in azurerm_netapp_account.netapp_accounts : k => v.id if v.id != null && length(v.id) > 0 }
}
output "netapp_accounts_active_directory" {
  description = "Map of active_directory values across all netapp_accounts, keyed the same as var.netapp_accounts"
  value       = { for k, v in azurerm_netapp_account.netapp_accounts : k => v.active_directory if v.active_directory != null && length(v.active_directory) > 0 }
  sensitive   = true
}
output "netapp_accounts_identity" {
  description = "Map of identity values across all netapp_accounts, keyed the same as var.netapp_accounts"
  value       = { for k, v in azurerm_netapp_account.netapp_accounts : k => v.identity if v.identity != null && length(v.identity) > 0 }
}
output "netapp_accounts_location" {
  description = "Map of location values across all netapp_accounts, keyed the same as var.netapp_accounts"
  value       = { for k, v in azurerm_netapp_account.netapp_accounts : k => v.location if v.location != null && length(v.location) > 0 }
}
output "netapp_accounts_name" {
  description = "Map of name values across all netapp_accounts, keyed the same as var.netapp_accounts"
  value       = { for k, v in azurerm_netapp_account.netapp_accounts : k => v.name if v.name != null && length(v.name) > 0 }
}
output "netapp_accounts_resource_group_name" {
  description = "Map of resource_group_name values across all netapp_accounts, keyed the same as var.netapp_accounts"
  value       = { for k, v in azurerm_netapp_account.netapp_accounts : k => v.resource_group_name if v.resource_group_name != null && length(v.resource_group_name) > 0 }
}
output "netapp_accounts_tags" {
  description = "Map of tags values across all netapp_accounts, keyed the same as var.netapp_accounts"
  value       = { for k, v in azurerm_netapp_account.netapp_accounts : k => v.tags if v.tags != null && length(v.tags) > 0 }
}

