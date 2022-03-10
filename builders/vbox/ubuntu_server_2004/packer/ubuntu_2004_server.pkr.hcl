variable "iso_checksum" {
  type    = string
  default = ""
}

variable "iso_url" {
  type    = string
  default = ""
}

source "virtualbox-iso" "vbox" {
  boot_command = [
    "<esc><esc><esc>",
    "<enter><wait>",
    "/casper/vmlinuz ",
    "root=/dev/sr0 ",
    "initrd=/casper/initrd ",
    "autoinstall ",
    "ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<enter>"
  ]
  boot_wait               = "5s"
  guest_additions_mode    = "disable"
  guest_os_type           = "ubuntu-64"
  headless                = false
  http_directory          = "http"
  iso_checksum            = "sha256:28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
  iso_url                 = "https://releases.ubuntu.com/20.04/ubuntu-20.04.4-live-server-amd64.iso"
  memory                  = 1024
  shutdown_command        = "echo 'ubuntu'|sudo -S shutdown -P now"
  ssh_handshake_attempts  = "100000"
  ssh_timeout             = "30m"
  ssh_password            = "ubuntu"
  ssh_username            = "ubuntu"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "1024"], ["modifyvm", "{{ .Name }}", "--cpus", "1"], ["modifyvm", "{{.Name}}", "--vram", "64"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "packer-ubuntu-20.04-amd64"
}

build {
  sources = ["source.virtualbox-iso.vbox"]

  provisioner "shell" {
    execute_command = "echo 'ubuntu' | {{ .Vars }} sudo -S bash -euxo pipefail '{{ .Path }}'"
    scripts         = ["scripts/setup_ubuntu2004.sh"]
  }
}
