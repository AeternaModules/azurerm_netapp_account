resource "azurerm_netapp_account" "netapp_accounts" {
  for_each = var.netapp_accounts

  location            = each.value.location
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags

  dynamic "active_directory" {
    for_each = each.value.active_directory != null ? [each.value.active_directory] : []
    content {
      aes_encryption_enabled            = active_directory.value.aes_encryption_enabled
      dns_servers                       = active_directory.value.dns_servers
      domain                            = active_directory.value.domain
      kerberos_ad_name                  = active_directory.value.kerberos_ad_name
      kerberos_kdc_ip                   = active_directory.value.kerberos_kdc_ip
      ldap_over_tls_enabled             = active_directory.value.ldap_over_tls_enabled
      ldap_signing_enabled              = active_directory.value.ldap_signing_enabled
      local_nfs_users_with_ldap_allowed = active_directory.value.local_nfs_users_with_ldap_allowed
      organizational_unit               = active_directory.value.organizational_unit
      password                          = active_directory.value.password
      server_root_ca_certificate        = active_directory.value.server_root_ca_certificate
      site_name                         = active_directory.value.site_name
      smb_server_name                   = active_directory.value.smb_server_name
      username                          = active_directory.value.username
    }
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      identity_ids = identity.value.identity_ids
      type         = identity.value.type
    }
  }
}

