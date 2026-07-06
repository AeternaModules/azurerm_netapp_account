output "netapp_accounts" {
  description = "All netapp_account resources"
  value       = azurerm_netapp_account.netapp_accounts
  sensitive   = true
}
output "netapp_accounts_active_directory" {
  description = "List of active_directory values across all netapp_accounts"
  value       = [for k, v in azurerm_netapp_account.netapp_accounts : v.active_directory]
  sensitive   = true
}
output "netapp_accounts_identity" {
  description = "List of identity values across all netapp_accounts"
  value       = [for k, v in azurerm_netapp_account.netapp_accounts : v.identity]
}
output "netapp_accounts_location" {
  description = "List of location values across all netapp_accounts"
  value       = [for k, v in azurerm_netapp_account.netapp_accounts : v.location]
}
output "netapp_accounts_name" {
  description = "List of name values across all netapp_accounts"
  value       = [for k, v in azurerm_netapp_account.netapp_accounts : v.name]
}
output "netapp_accounts_resource_group_name" {
  description = "List of resource_group_name values across all netapp_accounts"
  value       = [for k, v in azurerm_netapp_account.netapp_accounts : v.resource_group_name]
}
output "netapp_accounts_tags" {
  description = "List of tags values across all netapp_accounts"
  value       = [for k, v in azurerm_netapp_account.netapp_accounts : v.tags]
}

