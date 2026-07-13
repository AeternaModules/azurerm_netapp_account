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
  # --- Unconfirmed validation candidates, derived from azurerm_netapp_account's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   source:    [from netAppValidate.AccountName] !regexp.MustCompile(`^[-_\da-zA-Z]{3,64}$`).MatchString(value)
  # path: resource_group_name
  #   condition: length(value) <= 90
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) > 90]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) > 90]
  # path: resource_group_name
  #   condition: !endswith(value, ".")
  #   message:   [from resourcegroups.ValidateName: must not end with "."]
  #   source:    [from resourcegroups.ValidateName: must not end with "."]
  # path: resource_group_name
  #   condition: length(value) != 0
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) == 0]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) == 0]
  # path: resource_group_name
  #   source:    [from resourcegroups.ValidateName] !matched
  # path: location
  #   source:    location.EnhancedValidate: no recognizable `if ... { errors = append(...) }` pattern - read it by hand
  # path: identity.type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: identity.identity_ids[*]
  #   source:    [from commonids.ValidateUserAssignedIdentityID] !ok
  # path: identity.identity_ids[*]
  #   source:    [from commonids.ValidateUserAssignedIdentityID] err != nil
  # path: active_directory.dns_servers[*]
  #   source:    [from validate.IPv4Address] !ok
  # path: active_directory.dns_servers[*]
  #   source:    [from validate.IPv4Address] four == nil
  # path: active_directory.domain
  #   condition: can(regex("^[(\\da-zA-Z-).]{1,255}$", value))
  #   message:   The domain name must end with a letter or number before dot and start with a letter or number after dot and can not be longer than 255 characters in length.
  # path: active_directory.smb_server_name
  #   condition: can(regex("^[\\da-zA-Z\\-]{1,10}$", value))
  #   message:   smb_server_name can contain a mix of numbers, upper/lowercase letters, dashes, and be no longer than 10 characters.
  # path: active_directory.username
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: active_directory.password
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: active_directory.kerberos_kdc_ip
  #   source:    validation.IsIPv4Address(...) - no translation rule yet, add one
  # path: tags
  #   condition: length(value) <= 50
  #   message:   [from tags.Validate: invalid when len(value) > 50]
  #   source:    [from tags.Validate: invalid when len(value) > 50]
  # path: tags
  #   condition: length(value) <= 512
  #   message:   [from tags.Validate: invalid when len(value) > 512]
  #   source:    [from tags.Validate: invalid when len(value) > 512]
  # path: tags
  #   source:    [from tags.Validate] err != nil
  # path: tags
  #   condition: length(value) <= 256
  #   message:   [from tags.Validate: invalid when len(value) > 256]
  #   source:    [from tags.Validate: invalid when len(value) > 256]
}

