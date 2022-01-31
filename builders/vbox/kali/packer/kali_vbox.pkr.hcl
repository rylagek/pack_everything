variable "iso_checksum" {
  type    = string
  default = "4a9bf6623811c55e40f2691a53bfa33863cea18bd9a9c956cbd2e38fc799dd16"
}

variable "iso_url" {
  type    = string
  default = "https://cdimage.kali.org/kali-2021.4a/kali-linux-2021.4a-live-amd64.iso"
}

source "virtualbox-iso" "vbox" {
  boot_command            = ["<esc><wait>", "/install/vmlinuz<wait>", " auto<wait>", " console-setup/ask_detect=false<wait>", " console-setup/layoutcode=us<wait>", " console-setup/modelcode=pc105<wait>", " debconf/frontend=noninteractive<wait>", " debian-installer=en_US<wait>", " fb=false<wait>", " initrd=/install/initrd.gz<wait>", " kbd-chooser/method=us<wait>", " netcfg/choose_interface=eth0<wait>", " console-keymaps-at/keymap=us<wait>", " keyboard-configuration/xkb-keymap=us<wait>", " keyboard-configuration/layout=USA<wait>", " keyboard-configuration/variant=USA<wait>", " locale=en_US<wait>", " netcfg/get_domain=vm<wait>", " netcfg/get_hostname=kali<wait>", " grub-installer/bootdev=/dev/sda<wait>", " noapic<wait>", " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg auto=true priority=critical", " -- <wait>", "<enter><wait>"]
  boot_wait               = "10s"
  memory                  = "2048"
  guest_additions_mode    = "disable"
  guest_os_type           = "Debian_64"
  headless                = false
  http_directory          = "http"
  iso_checksum            = "sha256:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  shutdown_command        = "echo 'kali'|sudo -S shutdown -P now"
  ssh_password            = "kali"
  ssh_port                = 22
  ssh_timeout             = "8000s"
  ssh_username            = "kali"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "4096"], ["modifyvm", "{{ .Name }}", "--cpus", "1"], ["modifyvm", "{{.Name}}", "--vram", "64"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "packer-kali-2021_4a-amd64"
}

build {
  sources = ["source.virtualbox-iso.vbox"]
}
