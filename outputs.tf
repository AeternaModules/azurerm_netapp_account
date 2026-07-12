output "netapp_accounts_active_directory" {
  description = "Map of active_directory values across all netapp_accounts, keyed the same as var.netapp_accounts"
  value       = { for k, v in azurerm_netapp_account.netapp_accounts : k => v.active_directory }
  sensitive   = true
}
output "netapp_accounts_identity" {
  description = "Map of identity values across all netapp_accounts, keyed the same as var.netapp_accounts"
  value       = { for k, v in azurerm_netapp_account.netapp_accounts : k => v.identity }
}
output "netapp_accounts_location" {
  description = "Map of location values across all netapp_accounts, keyed the same as var.netapp_accounts"
  value       = { for k, v in azurerm_netapp_account.netapp_accounts : k => v.location }
}
output "netapp_accounts_name" {
  description = "Map of name values across all netapp_accounts, keyed the same as var.netapp_accounts"
  value       = { for k, v in azurerm_netapp_account.netapp_accounts : k => v.name }
}
output "netapp_accounts_resource_group_name" {
  description = "Map of resource_group_name values across all netapp_accounts, keyed the same as var.netapp_accounts"
  value       = { for k, v in azurerm_netapp_account.netapp_accounts : k => v.resource_group_name }
}
output "netapp_accounts_tags" {
  description = "Map of tags values across all netapp_accounts, keyed the same as var.netapp_accounts"
  value       = { for k, v in azurerm_netapp_account.netapp_accounts : k => v.tags }
}

