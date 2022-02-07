variable "iso_checksum" {
  type    = string
  default = "cdcbee6b1fdfb4caf6c9f80ccadc161366ec337746e8394bf4454faa2fc11aa1"
}

variable "iso_url" {
  type    = string
  default = "securityonion-2.3.100-20220131.iso"
}

source "virtualbox-iso" "vbox" {
  boot_command         = ["<esc><wait>", "vmlinuz initrd=initrd.img inst.stage2=hd:LABEL=CentOS\\x207\\x20x86_64 <wait>", "ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg nomodeset quiet", "<enter>"]
  cpus                 = "4"
  guest_additions_mode = "disable"
  guest_os_type        = "Ubuntu_64"
  http_directory       = "http"
  iso_checksum         = "sha256:${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  memory               = "13000"
  disk_size            = "150000"
  shutdown_command     = "echo 'packer' | sudo -S shutdown -P now"
  ssh_password         = "automation"
  ssh_timeout          = "60m"
  ssh_username         = "packer"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--clipboard-mode", "bidirectional"],
    ["modifyvm", "{{ .Name }}", "--draganddrop", "bidirectional"],
    ["modifyvm", "{{ .Name }}", "--nic2", "nat"]
  ]
  virtualbox_version_file = ""
}

build {
  sources = ["source.virtualbox-iso.vbox"]

  provisioner "shell" {
    execute_command = "echo 'vbox' | {{ .Vars }} sudo -S bash -euxo pipefail '{{ .Path }}'"
    scripts         = ["scripts/install.sh"]
  }
}
