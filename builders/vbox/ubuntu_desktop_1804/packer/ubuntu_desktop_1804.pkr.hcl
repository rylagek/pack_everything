source "virtualbox-iso" "vbox" {
  boot_command         = ["<esc><esc><f6><esc><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", " auto=true priority=critical noprompt ", " automatic-ubiquity ", " url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ", " keyboard-configuration/layoutcode=us ", " ubiquity/reboot=true ", " languagechooser/language-name=English ", " countrychooser/shortlist=IN ", " localechooser/supported-locales=en_US.UTF-8 ", " debian-installer/locale=en_US ", " netcfg/choose_interface=auto ", " boot=casper ", " initrd=/casper/initrd ", " --- <wait>", "<enter><wait>"]
  boot_wait            = "6s"
  headless             = false
  guest_additions_mode = "disable"
  guest_os_type        = "Ubuntu_64"
  http_directory       = "http"
  iso_checksum         = "sha256:f730be589aa1ba923ebe6eca573fa66d09ba14c4c104da2c329df652d42aff11"
  iso_url              = "http://releases.ubuntu.com/bionic/ubuntu-18.04.6-desktop-amd64.iso"
  shutdown_command     = "echo 'ubuntu' | sudo -S shutdown -P now"
  ssh_password         = "ubuntu"
  ssh_port             = 22
  ssh_username         = "ubuntu"
  ssh_wait_timeout     = "40m"
  vboxmanage           = [["modifyvm", "{{ .Name }}", "--memory", "1024"], ["modifyvm", "{{ .Name }}", "--cpus", "1"], ["modifyvm", "{{.Name}}", "--vram", "64"]]
  vm_name              = "packer-ubuntu-18.04-amd64"
}

build {

  sources = ["source.virtualbox-iso.vbox"]

  provisioner "shell" {
    execute_command = "echo 'ubuntu' | {{ .Vars }} sudo -S bash -euxo pipefail '{{ .Path }}'"
    scripts         = ["scripts/setup_ubuntu1804.sh"]
  }
}
