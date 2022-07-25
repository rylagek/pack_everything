variable "iso_checksum" {
  type    = string
  default = "f78d4e5f53605592863852b39fa31a12f15893dc48cacecd875f2da72fa67ae5"
}

variable "iso_url" {
  type    = string
  default = "https://download.freebsd.org/ftp/releases/amd64/amd64/ISO-IMAGES/13.0/FreeBSD-13.0-RELEASE-amd64-disc1.iso"
}

variable "rc_conf_file" {
  type    = string
  default = ""
}


source "virtualbox-iso" "vbox" {
  boot_command = [
        "<esc><wait>",
        "boot -s<wait>",
        "<enter><wait>",
        "<wait10><wait10>",
        "/bin/sh<enter><wait>",
        "mdmfs -s 100m md1 /tmp<enter><wait>",
        "mdmfs -s 100m md2 /mnt<enter><wait>",
        "dhclient -p /tmp/dhclient.em0.pid -l /tmp/dhclient.lease.em0 em0<enter><wait30s>",
        "fetch -o /tmp/installerconfig http://{{ .HTTPIP }}:{{ .HTTPPort }}/installerconfig<enter>",
        "<wait10>",
        "bsdinstall script /tmp/installerconfig<enter><wait>"
  ]
  cpus                    = "2"
  guest_additions_mode    = "disable"
  guest_os_type           = "FreeBSD_64"
  http_directory          = "http"
  iso_checksum            = "sha256:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  memory                  = "2048"
  shutdown_command        = "poweroff"
  ssh_password            = "freebsd"
  ssh_timeout             = "60m"
  ssh_username            = "root"
  virtualbox_version_file = ""
  vm_name                 = "packer-freebsd-13.0-amd64"
}

build {
  sources = ["source.virtualbox-iso.vbox"]
}
