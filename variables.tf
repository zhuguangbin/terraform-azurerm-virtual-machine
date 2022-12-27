variable "location" {
  description = "(Required) The Azure location where the Virtual Machine should exist. Changing this forces a new resource to be created."
  type        = string
  nullable    = false
}

variable "image_os" {
  description = "Enum flag of virtual machine's os system"
  type        = string
  nullable    = false
  validation {
    condition     = contains(["windows", "linux"], var.image_os)
    error_message = "`image_os` must be either `windows` or `linux`."
  }
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group in which the Virtual Machine should be exist. Changing this forces a new resource to be created."
  type        = string
  nullable    = false
}

variable "vnet_subnet_id" {
  description = "The subnet id of the virtual network where the virtual machines will reside."
  type        = string
  nullable    = false
}

variable "vm_name" {
  type        = string
  description = "(Required) The name of the Virtual Machine. Changing this forces a new resource to be created."
  nullable    = false
}

variable "vm_size" {
  description = "(Required) The SKU which should be used for this Virtual Machine, such as `Standard_F2`."
  type        = string
  nullable    = false
}

variable "admin_password" {
  description = "(Optional) The Password which should be used for the local-administrator on this Virtual Machine Required when using Windows Virtual Machine. Changing this forces a new resource to be created. When an `admin_password` is specified `disable_password_authentication` must be set to `false`. One of either `admin_password` or `admin_ssh_key` must be specified."
  type        = string
  default     = null
  sensitive   = true
}

variable "admin_username" {
  description = "The admin username of the VM that will be deployed."
  type        = string
  default     = "azureuser"
}

variable "allocation_method" {
  description = "Defines how an IP address is assigned. Options are Static or Dynamic."
  type        = string
  default     = "Dynamic"
}

variable "allow_extension_operations" {
  type        = bool
  description = "(Optional) Should Extension Operations be allowed on this Virtual Machine? Defaults to `true`."
  default     = true
}

variable "availability_set_id" {
  type        = string
  description = "(Optional) Specifies the ID of the Availability Set in which the Virtual Machine should exist. Cannot be used along with `new_availability_set`, `new_capacity_reservation_group`, `capacity_reservation_group_id`, `virtual_machine_scale_set_id`, `zone`. Changing this forces a new resource to be created."
  default     = null
}

variable "boot_diagnostics" {
  type        = bool
  description = "(Optional) Enable or Disable boot diagnostics."
  default     = false
  nullable    = false
}

variable "boot_diagnostics_sa_type" {
  description = "(Optional) Storage account type for boot diagnostics."
  type        = string
  default     = "Standard_LRS"
  nullable    = false
}

variable "capacity_reservation_group_id" {
  type        = string
  description = "(Optional) Specifies the ID of the Capacity Reservation Group which the Virtual Machine should be allocated to. Cannot be used with `new_capacity_reservation_group`, `availability_set_id`, `new_availability_set`, `proximity_placement_group_id`."
  default     = null
}

variable "compute_name" {
  type        = string
  description = "(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the `vm_name` field. If the value of the `vm_name` field is not a valid `computer_name`, then you must specify `computer_name`. Changing this forces a new resource to be created."
  default     = null
}

variable "create_public_ip" {
  type        = bool
  description = "Whether create a public IP and assign it to the vm or not."
  default     = false
  nullable    = false
}

variable "custom_data" {
  type        = string
  description = "(Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created."
  default     = null
  validation {
    condition     = var.custom_data == null ? true : can(base64decode(var.custom_data))
    error_message = "The `custom_data` must be either `null` or a valid Base64-Encoded string."
  }
}

variable "dedicated_host_id" {
  type        = string
  description = "(Optional) The ID of a Dedicated Host where this machine should be run on. Conflicts with `dedicated_host_group_id`."
  default     = null
}

variable "dedicated_host_group_id" {
  type        = string
  description = "(Optional) The ID of a Dedicated Host Group that this Linux Virtual Machine should be run within. Conflicts with `dedicated_host_id`."
  default     = null
}

variable "disable_password_authentication" {
  type        = bool
  description = "(Optional) Should Password Authentication be disabled on this Virtual Machine? Defaults to `true`. Changing this forces a new resource to be created."
  default     = true
}

variable "edge_zone" {
  type        = string
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine should exist. Changing this forces a new Virtual Machine to be created."
  default     = null
}

variable "enable_accelerated_networking" {
  type        = bool
  description = "(Optional) Enable accelerated networking on Network interface."
  default     = false
}

variable "enable_ssh_key" {
  type        = bool
  description = "(Optional) Enable ssh key authentication in Linux virtual Machine."
  default     = true
}

variable "encryption_at_host_enabled" {
  type        = bool
  description = "(Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
  default     = null
}

variable "eviction_policy" {
  type        = string
  description = "(Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are `Deallocate` and `Delete`. Changing this forces a new resource to be created."
  default     = null
}

variable "extensions_time_budget" {
  type        = string
  description = "(Optional) Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to 90 minutes (`PT1H30M`)."
  default     = "PT1H30M"
}

variable "is_marketplace_image" {
  description = "Boolean flag to notify when the image comes from the marketplace."
  type        = bool
  nullable    = false
  default     = false
}

variable "license_type" {
  description = "(Optional) For Linux virtual machine specifies the BYOL Type for this Virtual Machine, possible values are `RHEL_BYOS` and `SLES_BYOS`. For Windows virtual machine specifies the type of on-premise license (also known as [Azure Hybrid Use Benefit](https://docs.microsoft.com/windows-server/get-started/azure-hybrid-benefit)) which should be used for this Virtual Machine, possible values are `None`, `Windows_Client` and `Windows_Server`."
  type        = string
  default     = null
}

variable "max_bid_price" {
  type        = number
  description = "(Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the `eviction_policy`. Defaults to `-1`, which means that the Virtual Machine should not be evicted for price reasons. This can only be configured when `priority` is set to `Spot`."
  default     = -1
}

variable "network_security_group" {
  description = "The network security group we'd like to bind with virtual machine. Set this variable will disable the creation of `azurerm_network_security_group` and `azurerm_network_security_rule` resources."
  type        = object({
    id = string
  })
  default = null
  validation {
    condition     = var.network_security_group == null ? true : var.network_security_group.id != null
    error_message = "When `var.network_security_group` is not `null`, `var.network_security_group.id` is required."
  }
}

variable "new_availability_set" {
  type = object({
    name                         = string
    managed                      = optional(bool, true)
    platform_fault_domain_count  = optional(number, 3)
    platform_update_domain_count = optional(number, 5)
    proximity_placement_group_id = optional(string, null)
  })
  description = <<-EOT
  Creates a new Availability Set for Virtual Machines. Cannot be used along with `availability_set_id`, `new_capacity_reservation_group`, `capacity_reservation_group_id`, `zone`.
  object({
    name                         = "(Required) Specifies the name of the availability set. Changing this forces a new resource to be created."
    managed                      = "(Optional) Specifies whether the availability set is managed or not. Possible values are `true` (to specify aligned) or `false` (to specify classic). Default is `true`. Changing this forces a new resource to be created."
    platform_fault_domain_count  = "(Optional) Specifies the number of fault domains that are used. Defaults to `3`. Changing this forces a new resource to be created."
    platform_update_domain_count = "(Optional) Specifies the number of update domains that are used. Defaults to `5`. Changing this forces a new resource to be created. The number of Update Domains varies depending on which Azure Region you're using - [a list can be found here](https://github.com/MicrosoftDocs/azure-docs/blob/master/includes/managed-disks-common-fault-domain-region-list.md)."
    proximity_placement_group_id = "(Optional) The ID of the Proximity Placement Group to which this Virtual Machine should be assigned. Changing this forces a new resource to be created."
  })
  EOT
  default     = null
}

variable "new_capacity_reservation_group" {
  type = object({
    name  = string
    zones = optional(set(string), null)
  })
  description = <<-EOT
  object({
    name  = "(Required) Specifies the name of this Capacity Reservation Group. Changing this forces a new resource to be created."
    zones = "(Optional) Specifies a list of Availability Zones for this Capacity Reservation Group. Changing this forces a new resource to be created."
  })
  EOT
  default     = null
}

variable "new_dedicated_host_group" {
  type = object({
    name                        = string
    platform_fault_domain_count = number
    automatic_placement_enabled = optional(bool, false)
  })
  description = <<-EOT
  object({
    name = "(Required) Specifies the name of the Dedicated Host Group. Changing this forces a new resource to be created."
    platform_fault_domain_count = "(Required) The number of fault domains that the Dedicated Host Group spans. Changing this forces a new resource to be created."
    automatic_placement_enabled = "(Optional) Would virtual machines or virtual machine scale sets be placed automatically on this Dedicated Host Group? Defaults to `false`. Changing this forces a new resource to be created."
  })
  EOT
  default     = null
}

variable "patch_assessment_mode" {
  type        = string
  description = "(Optional) Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are `AutomaticByPlatform` or `ImageDefault`. Defaults to `ImageDefault`."
  default     = "ImageDefault"
}

variable "patch_mode" {
  type        = string
  description = "(Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine. Possible values are `AutomaticByPlatform` and `ImageDefault`. Defaults to `ImageDefault`. For more information on patch modes please see the [product documentation](https://docs.microsoft.com/azure/virtual-machines/automatic-vm-guest-patching#patch-orchestration-modes)."
  default     = null
}

variable "platform_fault_domain" {
  type        = number
  description = "(Optional) Specifies the Platform Fault Domain in which this Virtual Machine should be created. Defaults to `null`, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. `virtual_machine_scale_set_id` is required with it. Changing this forces new Virtual Machine to be created."
  # Why use `null` instead of [`-1`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine#platform_fault_domain) as default value? `platform_fault_domain` must be set along with `virtual_machine_scale_set_id` so the default value must be `null` for this module if we don't want to use `virtual_machine_scale_set_id`.
  default     = null
}

variable "priority" {
  type        = string
  description = "(Optional) Specifies the priority of this Virtual Machine. Possible values are `Regular` and `Spot`. Defaults to `Regular`. Changing this forces a new resource to be created."
  default     = "Regular"
}

variable "proximity_placement_group_id" {
  type        = string
  description = "(Optional) The ID of the Proximity Placement Group which the Virtual Machine should be assigned to. Conflicts with `capacity_reservation_group_id` and `capacity_reservation_group`."
  default     = null
}

variable "provision_vm_agent" {
  type        = bool
  description = "(Optional) Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to `true`. Changing this forces a new resource to be created. If `provision_vm_agent` is set to `false` then `allow_extension_operations` must also be set to `false`."
  default     = true
}

variable "public_ip_dns" {
  description = "Optional globally unique per datacenter region domain name label to apply to each public ip address. e.g. thisvar.varlocation.cloudapp.azure.com where you specify only thisvar here. This is an array of names which will pair up sequentially to the number of public ips defined in var.nb_public_ip. One name or empty string is required for every public ip. If no public ip is desired, then set this to an array with a single empty string."
  type        = list(string)
  default     = [null]
}

variable "public_ip_sku" {
  description = "Defines the SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
  type        = string
  default     = "Basic"
}

variable "nsg_public_open_port" {
  description = "Remote tcp port to be used for access to the vms created via the nsg applied to the nics."
  type        = string
  default     = null
}

variable "secure_boot_enabled" {
  type        = bool
  description = "(Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created."
  default     = null
}

variable "nsg_source_address_prefixes" {
  description = "(Optional) List of source address prefixes allowed to access var.remote_port."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "vm_source_image_id" {
  type        = string
  description = "(Optional) The ID of the Image which this Virtual Machine should be created from. Changing this forces a new resource to be created. Possible Image ID types include `Image ID`s, `Shared Image ID`s, `Shared Image Version ID`s, `Community Gallery Image ID`s, `Community Gallery Image Version ID`s, `Shared Gallery Image ID`s and `Shared Gallery Image Version ID`s. One of either `source_image_id` or `source_image_reference` must be set."
  default     = null
}

variable "vm_source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = <<-EOT
  object({
    publisher = "(Required) Specifies the publisher of the image used to create the virtual machines. Changing this forces a new resource to be created."
    offer     = "(Required) Specifies the offer of the image used to create the virtual machines. Changing this forces a new resource to be created."
    sku       = "(Required) Specifies the SKU of the image used to create the virtual machines. Changing this forces a new resource to be created."
    version   = "(Required) Specifies the version of the image used to create the virtual machines. Changing this forces a new resource to be created."
  })
  EOT
  default     = null
}

variable "ssh_key" {
  description = "Path to the public key to be used for ssh access to the VM. Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash.e.g. c : /home/id_rsa.pub."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_key_values" {
  description = "List of Public SSH Keys values to be used for ssh access to the VMs."
  type        = list(string)
  default     = []
}

variable "standard_os" {
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
  }))
  description = <<-EOT
  map(object({
    publisher = "(Required) Specifies the publisher of the image used to create the virtual machines. Changing this forces a new resource to be created."
    offer     = "(Required) Specifies the offer of the image used to create the virtual machines. Changing this forces a new resource to be created."
    sku       = "(Required) Specifies the SKU of the image used to create the virtual machines. Changing this forces a new resource to be created."
  }))
  EOT
  default     = {
    UbuntuServer = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
    }
    WindowsServer = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter"
    }
    RHEL = {
      publisher = "RedHat"
      offer     = "RHEL"
      sku       = "8.2"
    }
    openSUSE-Leap = {
      publisher = "SUSE"
      offer     = "openSUSE-Leap"
      sku       = "15.1"
    }
    CentOS = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "7.6"
    }
    Debian = {
      publisher = "credativ"
      offer     = "Debian"
      sku       = "9"
    }
    CoreOS = {
      publisher = "CoreOS"
      offer     = "CoreOS"
      sku       = "Stable"
    }
    SLES = {
      publisher = "SUSE"
      offer     = "SLES"
      sku       = "12-SP2"
    }
  }
  nullable = false
}

variable "storage_account_type" {
  description = "Defines the type of storage account to be created. Valid options are Standard_LRS, Standard_ZRS, Standard_GRS, Standard_RAGRS, Premium_LRS."
  type        = string
  default     = "Premium_LRS"
}

variable "storage_os_disk_size_gb" {
  description = "(Optional) Specifies the size of the data disk in gigabytes."
  type        = number
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."

  default = {
    source = "terraform"
  }
}

variable "user_data" {
  type        = string
  description = "(Optional) The Base64-Encoded User Data which should be used for this Virtual Machine."
  default     = null
  validation {
    condition     = var.user_data == null ? true : can(base64decode(var.user_data))
    error_message = "`user_data` must be either `null` or valid base64 encoded string."
  }
}

variable "virtual_machine_scale_set_id" {
  type        = string
  description = "(Optional) Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within. Conflicts with `availability_set_id` and `new_availability_set`. Changing this forces a new resource to be created."
  default     = null
}

variable "vm_additional_capabilities" {
  type = object({
    ultra_ssd_enabled = optional(bool, false)
  })
  description = <<-EOT
  object({
    ultra_ssd_enabled = "(Optional) Should the capacity to enable Data Disks of the `UltraSSD_LRS` storage account type be supported on this Virtual Machine? Defaults to `false`."
  })
  EOT
  default     = null
}

variable "vm_additional_unattend_contents" {
  type = list(object({
    content = string
    setting = string
  }))
  description = <<-EOT
  list(object({
    content = "(Required) The XML formatted content that is added to the unattend.xml file for the specified path and component. Changing this forces a new resource to be created."
    setting = "(Required) The name of the setting to which the content applies. Possible values are `AutoLogon` and `FirstLogonCommands`. Changing this forces a new resource to be created."
  }))
  EOT
  default     = []
}

variable "vm_automatic_updates_enabled" {
  type        = bool
  description = "(Optional) Specifies if Automatic Updates are Enabled for the Windows Virtual Machine. Changing this forces a new resource to be created. Defaults to `true`."
  default     = true
}

variable "vm_boot_diagnostics" {
  type = object({
    storage_account_uri = optional(string)
  })
  description = <<-EOT
  object({
    storage_account_uri = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor. Passing a null value will utilize a Managed Storage Account to store Boot Diagnostics"
  })
  EOT
  default     = null
}

variable "vm_admin_ssh_key" {
  type = set(object({
    public_key = string
    username   = string
  }))
  description = <<-EOT
  set(object({
    public_key = "(Required) The Public Key which should be used for authentication, which needs to be at least 2048-bit and in `ssh-rsa` format. Changing this forces a new resource to be created."
    username   = "(Required) The Username for which this Public SSH Key should be configured. Changing this forces a new resource to be created. The Azure VM Agent only allows creating SSH Keys at the path `/home/{username}/.ssh/authorized_keys` - as such this public key will be written to the authorized keys file."
  }))
  EOT
  default     = []
}

variable "vm_gallery_application" {
  type = list(object({
    version_id             = string
    configuration_blob_uri = optional(string)
    order                  = optional(number, 0)
    tag                    = optional(string)
  }))
  description = <<-EOT
  list(object({
    version_id             = "(Required) Specifies the Gallery Application Version resource ID."
    configuration_blob_uri = "(Optional) Specifies the URI to an Azure Blob that will replace the default configuration for the package if provided."
    order                  = "(Optional) Specifies the order in which the packages have to be installed. Possible values are between `0` and `2,147,483,647`."
    tag                    = "(Optional) Specifies a passthrough value for more generic context. This field can be any valid `string` value."
  }))
  EOT
  default     = []
}

variable "vm_hotpatching_enabled" {
  type        = bool
  description = "(Optional) Should the VM be patched without requiring a reboot? Possible values are `true` or `false`. Defaults to `false`. For more information about hot patching please see the [product documentation](https://docs.microsoft.com/azure/automanage/automanage-hotpatch). Hotpatching can only be enabled if the `patch_mode` is set to `AutomaticByPlatform`, the `provision_vm_agent` is set to `true`, your `source_image_reference` references a hotpatching enabled image, and the VM's `size` is set to a [Azure generation 2](https://docs.microsoft.com/azure/virtual-machines/generation-2#generation-2-vm-sizes) VM. An example of how to correctly configure a Windows Virtual Machine to use the `hotpatching_enabled` field can be found in the [`./examples/virtual-machines/windows/hotpatching-enabled`](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/virtual-machines/windows/hotpatching-enabled) directory within the GitHub Repository."
  default     = false
}

variable "vm_identity" {
  type = object({
    type         = string
    identity_ids = optional(set(string))
  })
  description = <<-EOT
  object({
    type         = "(Required) Specifies the type of Managed Service Identity that should be configured on this Linux Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."
    identity_ids = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Linux Virtual Machine. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned`."
  })
  EOT
  default     = null
}

variable "vm_plan" {
  type = object({
    name      = string
    product   = string
    publisher = string
  })
  description = <<-EOT
  object({
    name      = "(Required) Specifies the Name of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created."
    product   = "(Required) Specifies the Product of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created."
    publisher = "(Required) Specifies the Publisher of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created."
  })
  EOT
  default     = null
}

variable "vm_secrets" {
  type = list(object({
    key_vault_id = string
    certificate  = set(object({
      url   = string
      store = optional(string)
    }))
  }))
  description = <<-EOT
  list(object({
    key_vault_id = "(Required) The ID of the Key Vault from which all Secrets should be sourced."
    certificate  = set(object({
      url   = "(Required) The Secret URL of a Key Vault Certificate. This can be sourced from the `secret_id` field within the `azurerm_key_vault_certificate` Resource."
      store = "(Optional) The certificate store on the Virtual Machine where the certificate should be added. Required when use with Windows Virtual Machine."
    }))
  }))
  EOT
  default     = []
  nullable    = false
}

variable "vm_termination_notification" {
  type = object({
    enabled = bool
    timeout = optional(string, "PT5M")
  })
  description = <<-EOT
  object({
    enabled = bool
    timeout = optional(string, "PT5M")
  })
  EOT
  default     = null
}


variable "vm_timezone" {
  type        = string
  description = "(Optional) Specifies the Time Zone which should be used by the Virtual Machine, [the possible values are defined here](https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/). Changing this forces a new resource to be created."
  default     = null
}

variable "vm_winrm_listeners" {
  type = set(object({
    protocol        = string
    certificate_url = optional(string)
  }))
  description = <<-EOT
  set(object({
    protocol        = "(Required) Specifies Specifies the protocol of listener. Possible values are `Http` or `Https`"
    certificate_url = "(Optional) The Secret URL of a Key Vault Certificate, which must be specified when `protocol` is set to `Https`. Changing this forces a new resource to be created."
  }))
  EOT
  default     = []
  nullable    = false
}

variable "vm_os_disk" {
  type = object({
    caching                          = string
    storage_account_type             = string
    disk_encryption_set_id           = optional(string)
    disk_size_gb                     = optional(number)
    name                             = optional(string)
    secure_vm_disk_encryption_set_id = optional(string)
    security_encryption_type         = optional(string)
    write_accelerator_enabled        = optional(bool, false)
    diff_disk_settings               = optional(object({
      option    = string
      placement = optional(string, "CacheDisk")
    }), null)
  })
  description = <<-EOT
  object({
    caching                          = "(Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite`."
    storage_account_type             = "(Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are `Standard_LRS`, `StandardSSD_LRS`, `Premium_LRS`, `StandardSSD_ZRS` and `Premium_ZRS`. Changing this forces a new resource to be created."
    disk_encryption_set_id           = "(Optional) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. Conflicts with `secure_vm_disk_encryption_set_id`. The Disk Encryption Set must have the `Reader` Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault"
    disk_size_gb                     = "(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. If specified this must be equal to or larger than the size of the Image the Virtual Machine is based on. When creating a larger disk than exists in the image you'll need to repartition the disk to use the remaining space."
    name                             = "(Optional) The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created."
    secure_vm_disk_encryption_set_id = "(Optional) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk when the Virtual Machine is a Confidential VM. Conflicts with `disk_encryption_set_id`. Changing this forces a new resource to be created. `secure_vm_disk_encryption_set_id` can only be specified when `security_encryption_type` is set to `DiskWithVMGuestState`."
    security_encryption_type         = "(Optional) Encryption Type when the Virtual Machine is a Confidential VM. Possible values are `VMGuestStateOnly` and `DiskWithVMGuestState`. Changing this forces a new resource to be created. `vtpm_enabled` must be set to `true` when `security_encryption_type` is specified. `encryption_at_host_enabled` cannot be set to `true` when `security_encryption_type` is set to `DiskWithVMGuestState`."
    write_accelerator_enabled        = "(Optional) Should Write Accelerator be Enabled for this OS Disk? Defaults to `false`. This requires that the `storage_account_type` is set to `Premium_LRS` and that `caching` is set to `None`."
    diff_disk_settings               = optional(object({
      option    = "(Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is `Local`. Changing this forces a new resource to be created."
      placement = "(Optional) Specifies where to store the Ephemeral Disk. Possible values are `CacheDisk` and `ResourceDisk`. Defaults to `CacheDisk`. Changing this forces a new resource to be created."
    }), [])
  })
  EOT
  nullable    = false
}

variable "vm_os_simple" {
  description = "Specify UbuntuServer, WindowsServer, RHEL, openSUSE-Leap, CentOS, Debian, CoreOS and SLES to get the latest image version of the specified os.  Do not provide this value if a custom value is used for vm_os_publisher, vm_os_offer, and vm_os_sku."
  type        = string
  default     = null
}

variable "vm_os_version" {
  description = "The version of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  type        = string
  default     = "latest"
  nullable    = false
}

variable "vtpm_enabled" {
  type        = bool
  description = "(Optional) Specifies whether vTPM should be enabled on the virtual machine. Changing this forces a new resource to be created."
  default     = null
}

# Why we use `zone` not `zones` as `azurerm_virtual_machine.zones`?
# `azurerm_virtual_machine.zones` is [a list of single Az](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine#zones), the maximum length is `1`
# so we can only pass one zone per vm instance.
# Why don't we use [`element`](https://developer.hashicorp.com/terraform/language/functions/element) function?
# The `element` function act as mod operator, it will iterate the vm instances, meanwhile
# we must keep the vm and public ip in the same zone.
# The vm's count is controlled by `var.nb_instances` and public ips' count is controled by `var.nb_public_ip`,
# it would be hard for us to keep the vm and public ip in the same zone once `var.nb_instances` doesn't equal to `var.nb_public_ip`
# So, we decide that one module instance supports one zone only to avoid this dilemma.
variable "zone" {
  description = "(Optional) The Availability Zone which the Virtual Machine should be allocated in, only one zone would be accepted. If set then this module won't create `azurerm_availability_set` resource. Changing this forces a new resource to be created."
  type        = string
  default     = null
}
