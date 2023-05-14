variable "proxmox_vmid_start" {
  description = "Proxmox VMID start"
  default = 7400
  type = number
}

variable "os_lab_nameserver" {
  description = "DNS Nameserver for Lab Infra"
  type        = string
  sensitive   = false
}

variable "os_lab_searchdomain" {
  description = "Search Domain for Lab Infra"
  type        = string
  sensitive   = false
}

variable "pm_api_url" {
  description = "Proxmox API URL"
  type = string
}

variable "pm_api_token_id" {
    description = "Proxmox API token id"
    default = "root@pam!terraformtoken"
}

variable "pm_api_secret" {
  description = "Proxmox API Secret"
  type = string
  sensitive = true   
}

variable "proxmox_target_storage" {
  description = "Proxmox Target Storage"
  default = "nvmenfs-disks"
  type = string
}

variable "proxmox_target_bridge" {
  description = "Proxmox Target Bridge"
  default = "vmbr0"
  type = string
}

variable "proxmox_target_host" {
  description = "Proxmox Target Host"
  default = "nuc3"
  type = string
}

variable "proxmox_target_pool" {
  description = "Proxmox Target Pool"
  default = "os4-lab"
  type = string
}