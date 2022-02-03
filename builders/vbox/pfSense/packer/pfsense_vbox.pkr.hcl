variable "iso_checksum" {
  type    = string
  default = "0266a16aa070cbea073fd4189a5a376d89c2d3e1dacc172c31f7e4e75b1db6bd"
}

variable "iso_url" {
  type    = string
  default = "https://atxfiles.netgate.com/mirror/downloads/pfSense-CE-2.5.2-RELEASE-amd64.iso.gz"
}

source "virtualbox-iso" "vbox" {
  boot_command = [
    "<enter><wait5>",
    "<enter><wait5>",
    "<enter><wait5>",
    "<enter><wait5>",
    "<enter><wait5>",
    "<enter><wait5>",
    "<spacebar><enter><wait5>",
    "y<wait2m>",
    "y<wait10>",
    "passwd<enter><wait5>",
    "pfsense<enter><wait>pfsense<enter><wait>exit<enter><wait10>r<wait2m>",
    "n<enter><wait>",
    "em0<enter><wait>",
    "<enter><wait>",
    "y<enter><wait1m>",
    "14<enter><wait>y<enter><wait>",
  ]
  boot_wait               = "1m"
  cpus                    = "2"
  guest_additions_mode    = "disable"
  guest_os_type           = "FreeBSD_64"
  iso_checksum            = "sha256:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  memory                  = "2048"
  shutdown_command        = ""
  communicator            = "none"
  ssh_password            = "root"
  ssh_timeout             = "5m"
  ssh_username            = "pfsense"
  virtualbox_version_file = ""
}

build {
  sources = ["source.virtualbox-iso.vbox"]
}
