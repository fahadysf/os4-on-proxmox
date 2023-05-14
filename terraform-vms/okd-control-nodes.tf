locals {
  hostname      = "bootstrap.os4.os.lab"
  iso           = "wdnfs-os-images:iso/rhcos-4.12.17-x86_64-live.x86_64.iso"
}

resource "proxmox_vm_qemu" "os-control-node" {
  count = 3
  #name  = "${var.vm_hostname}-${count.index}"
  #desc  = "A test for using terraform and cloudinit"
  #vmid  = var.proxmox_vmid_start+count.index 
  #agent = 1
  name  = "n${count.index+1}.os4.os.lab" 
  desc  = "OpenShift 4 Control Node"
  vmid  = var.proxmox_vmid_start+40+count.index+1 
  agent = 0 
  oncreate  = "false"

  target_node = "${var.proxmox_target_host}"
  pool = "${var.proxmox_target_pool}"

  # The template name to clone this vm from
  iso       = local.iso
  os_type   = "centos"
  sockets   = 1
  cores     = 4
  cpu       = "host"
  memory    = 16384
  scsihw    = "virtio-scsi-pci"
  boot      = "order=virtio0;ide2;net0"

  # Correcting fields which show taint after deployment
  args      = ""
  cicustom  = ""
  qemu_os   = "l26"
  # Setup the disk
  disk {
    size    = "100G"
    type    = "virtio"
    storage = "nvmenfs-disks"
    cache   = "writeback"
    discard = "ignore"
  }

  # Setup the network interface and assign a vlan tag: 256
  network {
    bridge    = "${var.proxmox_target_bridge}"
    firewall  = false
    link_down = false
    macaddr   = "BA:38:33:75:11:0${count.index}"
    model     = "virtio"
    queues    = 0
    rate      = 0
    tag       = 74
  }

}

