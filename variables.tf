variable "netapp_accounts" {
  description = <<EOT
Map of netapp_accounts, attributes below
Required:
    - location
    - name
    - resource_group_name
Optional:
    - tags
    - active_directory (block):
        - aes_encryption_enabled (optional)
        - dns_servers (required)
        - domain (required)
        - kerberos_ad_name (optional)
        - kerberos_kdc_ip (optional)
        - ldap_over_tls_enabled (optional)
        - ldap_signing_enabled (optional)
        - local_nfs_users_with_ldap_allowed (optional)
        - organizational_unit (optional)
        - password (required)
        - server_root_ca_certificate (optional)
        - site_name (optional)
        - smb_server_name (required)
        - username (required)
    - identity (block):
        - identity_ids (optional)
        - type (required)
EOT

  type = map(object({
    location            = string
    name                = string
    resource_group_name = string
    tags                = optional(map(string))
    active_directory = optional(object({
      aes_encryption_enabled            = optional(bool) # Default: false
      dns_servers                       = list(string)
      domain                            = string
      kerberos_ad_name                  = optional(string)
      kerberos_kdc_ip                   = optional(string)
      ldap_over_tls_enabled             = optional(bool)   # Default: false
      ldap_signing_enabled              = optional(bool)   # Default: false
      local_nfs_users_with_ldap_allowed = optional(bool)   # Default: false
      organizational_unit               = optional(string) # Default: "CN=Computers"
      password                          = string
      server_root_ca_certificate        = optional(string)
      site_name                         = optional(string) # Default: "Default-First-Site-Name"
      smb_server_name                   = string
      username                          = string
    }))
    identity = optional(object({
      identity_ids = optional(set(string))
      type         = string
    }))
  }))
}

