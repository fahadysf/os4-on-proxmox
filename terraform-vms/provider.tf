terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  # Configuration options
  pm_api_url = var.pm_api_url 
  pm_api_token_id = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_secret

  # Insecure connection
  pm_tls_insecure = true
  pm_parallel   = 2
  # Enable logging
  pm_log_enable = true
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}
