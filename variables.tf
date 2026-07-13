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
      aes_encryption_enabled            = optional(bool)
      dns_servers                       = list(string)
      domain                            = string
      kerberos_ad_name                  = optional(string)
      kerberos_kdc_ip                   = optional(string)
      ldap_over_tls_enabled             = optional(bool)
      ldap_signing_enabled              = optional(bool)
      local_nfs_users_with_ldap_allowed = optional(bool)
      organizational_unit               = optional(string)
      password                          = string
      server_root_ca_certificate        = optional(string)
      site_name                         = optional(string)
      smb_server_name                   = string
      username                          = string
    }))
    identity = optional(object({
      identity_ids = optional(set(string))
      type         = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.netapp_accounts : (
        length(v.resource_group_name) <= 90
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) > 90]"
  }
  validation {
    condition = alltrue([
      for k, v in var.netapp_accounts : (
        !endswith(v.resource_group_name, ".")
      )
    ])
    error_message = "[from resourcegroups.ValidateName: must not end with \".\"]"
  }
  validation {
    condition = alltrue([
      for k, v in var.netapp_accounts : (
        length(v.resource_group_name) != 0
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) == 0]"
  }
  validation {
    condition = alltrue([
      for k, v in var.netapp_accounts : (
        v.active_directory == null || (can(regex("^[(\\da-zA-Z-).]{1,255}$", v.active_directory.domain)))
      )
    ])
    error_message = "The domain name must end with a letter or number before dot and start with a letter or number after dot and can not be longer than 255 characters in length."
  }
  validation {
    condition = alltrue([
      for k, v in var.netapp_accounts : (
        v.active_directory == null || (can(regex("^[\\da-zA-Z\\-]{1,10}$", v.active_directory.smb_server_name)))
      )
    ])
    error_message = "smb_server_name can contain a mix of numbers, upper/lowercase letters, dashes, and be no longer than 10 characters."
  }
  validation {
    condition = alltrue([
      for k, v in var.netapp_accounts : (
        v.active_directory == null || (length(v.active_directory.username) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.netapp_accounts : (
        v.active_directory == null || (length(v.active_directory.password) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.netapp_accounts : (
        v.tags == null || (length(v.tags) <= 50)
      )
    ])
    error_message = "[from tags.Validate: invalid when len(value) > 50]"
  }
  # Note: 12 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

