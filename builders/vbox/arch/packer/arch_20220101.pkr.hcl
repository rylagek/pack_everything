variable "iso_checksum" {
  type    = string
  default = "efc9c33087e756ba1c7f326e67bfaa685eb51be3"
}

variable "iso_url" {
  type    = string
  default = "http://www.gtlib.gatech.edu/pub/archlinux/iso/2022.01.01/archlinux-2022.01.01-x86_64.iso"
}

source "virtualbox-iso" "vbox" {
  boot_command = [
    "<enter><wait1m>",
    "curl -sfSLO http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter><wait>",
    "curl -sfSLO http://{{ .HTTPIP }}:{{ .HTTPPort }}/bootloader.sh<enter><wait>",
    "curl -sfSLO http://{{ .HTTPIP }}:{{ .HTTPPort }}/partition.sh<enter><wait>",
    "curl -sfSLO http://{{ .HTTPIP }}:{{ .HTTPPort }}/packer.sh<enter><wait>",
    "chmod +x *.sh<enter><wait>",
    "./install.sh<enter>"
  ]
  boot_wait               = "10s"
  cpus                    = "2"
  headless                = false
  guest_additions_mode    = "disable"
  guest_os_type           = "ArchLinux_64"
  http_directory          = "http"
  iso_checksum            = "sha1:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  memory                  = "2048"
  shutdown_command        = "sudo systemctl poweroff"
  ssh_password            = "arch"
  ssh_username            = "root"
  ssh_timeout             = "60m"
  ssh_handshake_attempts  = "80000"
  virtualbox_version_file = ""
  disk_size               = "8000"
}

build {
  sources = ["source.virtualbox-iso.vbox"]
}
