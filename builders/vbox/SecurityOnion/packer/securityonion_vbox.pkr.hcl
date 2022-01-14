variable "iso_checksum" {
  type    = string
  default = "BAA8BEF574ECCB9ADC326D736A00C00AAF940FC6AD68CF491FF1F0AB6C5BAA64"
}

variable "iso_url" {
  type    = string
  default = "https://download.securityonion.net/file/securityonion/securityonion-2.3.91.iso"
}

source "virtualbox-iso" "vbox" {
  boot_command            = ["<esc><wait>", "install <wait>", "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ", "locale=en_US ", "keymap=us ", "hostname=kali ", "domain='' ", "<enter>"]
  cpus                    = "4"
  guest_additions_mode    = "disable"
  guest_os_type           = "Ubuntu_64"
  http_directory          = "http"
  iso_checksum            = "sha256:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  memory                  = "13000"
  disk_size               = "150000"
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
    scripts         = ["scripts/vbox.sh", "scripts/minimize.sh"]
  }
}
