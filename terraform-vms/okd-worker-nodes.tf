resource "proxmox_vm_qemu" "os-wn" {
  count = 3
  name  = "wn${count.index+1}.os4.ls.lab" 
  desc  = "Openshift 4 Worker Node"
  vmid  = var.proxmox_vmid_start+50+count.index+1
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
  memory    = 8192
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
    discard = "on"
    cache   = "writeback"
  }

  # Setup the network interface and assign a vlan tag: 256
  network {
    bridge    = "${var.proxmox_target_bridge}"
    firewall  = false
    link_down = false
    macaddr   = "BA:38:33:75:21:0${count.index}"
    model     = "virtio"
    queues    = 0
    rate      = 0
    tag       = 74
  }

  serial {
    id        = 0
    type      = "socket"
  }

}
