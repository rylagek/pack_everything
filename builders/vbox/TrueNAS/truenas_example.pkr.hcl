variable "iso_checksum" {
  type    = string
  default = "b584020dcce3a2281876be24b0c48a5d6641b787967ccd269028ff72e4a96065"
}

variable "iso_url" {
  type    = string
  default = "https://download.freenas.org/12.0/STABLE/U7/x64/TrueNAS-12.0-U7.iso?__hstc=123088916.c2f77ebf39729f61b2001e414a86dbcf.1642087483193.1642087483193.1642087483193.1&__hssc=123088916.6.1642087483194&__hsfp=595568833"
}

source "virtualbox-iso" "vbox" {
  boot_command            = ["<esc><wait>", "install <wait>", "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ", "locale=en_US ", "keymap=us ", "hostname=TrueNAS ", "domain='' ", "<enter>"]
  cpus                    = "2"
  guest_additions_mode    = "disable"
  guest_os_type           = "TrueNAS"
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
    scripts         = ["scripts/vbox.sh", "scripts/minimize.sh"]
  }
}