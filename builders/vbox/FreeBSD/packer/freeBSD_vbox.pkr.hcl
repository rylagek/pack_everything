variable "iso_checksum" {
  type    = string
  default = "c81a911f9d5fc7404877dd679771d776e1447cc38b31e1c07042d2620e49d4ac"
}

variable "iso_url" {
  type    = string
  default = "https://download.freebsd.org/ftp/releases/amd64/amd64/ISO-IMAGES/13.0/FreeBSD-13.0-RELEASE-amd64-bootonly.iso"
}

source "virtualbox-iso" "vbox" {
  boot_command            = ["<esc><wait>", "boot -s<enter>", "<wait15s>", "/bin/sh<enter><wait>", "mdmfs -s 100m md /tmp<enter><wait>", "dhclient -l /tmp/dhclient.lease.vtnet0 vtnet0<enter><wait5>", "fetch -o /tmp/installerconfig http://{{ .HTTPIP }}:{{ .HTTPPort }}/installerconfig<enter><wait5>", "bsdinstall script /tmp/installerconfig<enter>"]
  cpus                    = "2"
  guest_additions_mode    = "disable"
  guest_os_type           = "FreeBSD_64"
  http_directory          = "http"
  iso_checksum            = "sha256:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  memory                  = "2048"
  shutdown_command        = "echo 'packer' | sudo -S shutdown -P now"
  ssh_password            = "vbox"
  ssh_timeout             = "60m"
  ssh_username            = "vbox"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--clipboard-mode", "bidirectional"], ["modifyvm", "{{ .Name }}", "--draganddrop", "bidirectional"]]
  virtualbox_version_file = ""
}

build {
  sources = ["source.virtualbox-iso.vbox"]

  provisioner "shell" {
    execute_command = "echo 'vbox' | {{ .Vars }} sudo -S bash -euxo pipefail '{{ .Path }}'"
    scripts         = [
                        "scripts/vbox.sh",
                        "scripts/init.sh",
                        "scripts/sshd.sh",
                        "scripts/cleanup.sh",
                        "scripts/minimize.sh"
                      ]
  }
}