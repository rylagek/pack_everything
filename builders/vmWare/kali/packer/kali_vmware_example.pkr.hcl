variable "iso_checksum" {
  type    = string
  default = "d44126668b493ebc511eecf882bda351296696c51f4a8f1747f2e0364dc157b9"
}

variable "iso_url" {
  type    = string
  default = "kali.iso"
}

source "vmware-iso" "vmware" {
  boot_command         = ["<esc><wait>", "/install/vmlinuz<wait>", " auto<wait>", " console-setup/ask_detect=false<wait>", " console-setup/layoutcode=us<wait>", " console-setup/modelcode=pc105<wait>", " debconf/frontend=noninteractive<wait>", " debian-installer=en_US<wait>", " fb=false<wait>", " initrd=/install/initrd.gz<wait>", " kbd-chooser/method=us<wait>", " netcfg/choose_interface=eth0<wait>", " console-keymaps-at/keymap=us<wait>", " keyboard-configuration/xkb-keymap=us<wait>", " keyboard-configuration/layout=USA<wait>", " keyboard-configuration/variant=USA<wait>", " locale=en_US<wait>", " netcfg/get_domain=vm<wait>", " netcfg/get_hostname=kali<wait>", " grub-installer/bootdev=/dev/sda<wait>", " noapic<wait>", " preseed/file=/preseed.cfg auto=true priority=critical", " -- <wait>", "<enter><wait>"]
  boot_wait            = "10s"
  cpus                 = "2"
  guest_os_type        = "debian10-64"
  iso_checksum         = "sha256:${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  memory               = "2048"
  network              = "nat"
  network_adapter_type = "vmxnet3"
  shutdown_command     = "echo 'kali' | sudo -S shutdown -P now"
  ssh_password         = "toor"
  ssh_timeout          = "60m"
  ssh_username         = "root"
  vm_name              = "packer-kali-20214a-amd64"
  vmx_data_post = {
    "ide0:0.clientDevice"   = "TRUE"
    "ide0:0.deviceType"     = "cdrom-raw"
    "ide0:0.fileName"       = "emptyBackingString"
    "ide0:0.present"        = "FALSE"
    "ide0:0.startConnected" = "FALSE"
  }
}

build {
  sources = ["source.vmware-iso.vmware"]
}
