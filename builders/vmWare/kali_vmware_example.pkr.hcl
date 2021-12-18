variable "iso_checksum" {
  type    = string
  default = ""
}

variable "iso_url" {
  type    = string
  default = ""
}

source "vmware-iso" "vmware" {
  boot_command         = ["<esc><wait>", "install <wait>", "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ", "locale=en_US ", "keymap=us ", "hostname=kali ", "domain='' ", "<enter>"]
  cpus                 = "2"
  guest_os_type        = "debian10-64"
  http_directory       = "http"
  iso_checksum         = "sha256:${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  memory               = "2048"
  network              = "nat"
  network_adapter_type = "vmxnet3"
  shutdown_command     = "echo 'packer' | sudo -S shutdown -P now"
  ssh_password         = "vmware"
  ssh_timeout          = "60m"
  ssh_username         = "vmware"
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

  provisioner "shell" {
    execute_command = "echo 'vmware' | {{ .Vars }} sudo -S bash -euxo pipefail '{{ .Path }}'"
    scripts         = ["scripts/vmware.sh", "scripts/minimize.sh"]
  }
}