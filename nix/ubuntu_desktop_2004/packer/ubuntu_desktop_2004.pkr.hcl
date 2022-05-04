variable "iso_checksum" {
  type    = string
  default = "f92f7dca5bb6690e1af0052687ead49376281c7b64fbe4179cc44025965b7d1c"
}

variable "iso_url" {
  type    = string
  default = "https://releases.ubuntu.com/20.04/ubuntu-20.04.4-desktop-amd64.iso"
}

source "virtualbox-iso" "vbox" {
  boot_command            = ["<esc><wait>", "<enter><wait><esc><enter>", "/casper/vmlinuz root=/dev/sr0 initrd=/casper/initrd auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ", "locale=en_US ", "keymap=us ", "hostname=vbox ", "domain='' ", "<enter>"]
  boot_wait               = "5s"
  cpus                    = "2"
  guest_additions_mode    = "disable"
  guest_os_type           = "Ubuntu_64"
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

  /*provisioner "shell" {
    execute_command = "echo 'vbox' | {{ .Vars }} sudo -S bash -euxo pipefail '{{ .Path }}'"
    scripts         = ["scripts/vbox.sh", "scripts/minimize.sh"]
  }*/
}
