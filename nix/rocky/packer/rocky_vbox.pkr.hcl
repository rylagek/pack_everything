variable "boot_wait" {
  type    = string
  default = "5s"
}

variable "disk_size" {
  type    = string
  default = "40960"
}

variable "iso_checksum" {
  type    = string
  default = "5a0dc65d1308e47b51a49e23f1030b5ee0f0ece3702483a8a6554382e893333c"
}

variable "iso_url" {
  type    = string
  default = "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-boot.iso"
}

variable "memsize" {
  type    = string
  default = "1024"
}

variable "numvcpus" {
  type    = string
  default = "1"
}

variable "ssh_password" {
  type    = string
  default = "packer"
}

variable "ssh_username" {
  type    = string
  default = "packer"
}

variable "vm_name" {
  type    = string
  default = "Rocky-8.4-x86_64"
}

source "virtualbox-iso" "vbox" {
  boot_command     = ["<tab><bs><bs><bs><bs><bs>text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"]
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  guest_os_type    = "RedHat_64"
  headless         = false
  http_directory   = "http"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = "${var.ssh_username}"
  vboxmanage       = [["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"]]
  vm_name          = "${var.vm_name}"
}

build {
  sources = ["source.virtualbox-iso.vbox"]

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline          = ["dnf -y update", "dnf -y install python3", "alternatives --set python /usr/bin/python3", "python3 -m pip install -U pip", "python3 -m pip install ansible"]
  }

  #provisioner "ansible-local" {
  #  playbook_file = "scripts/setup.yml"
  #}

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = ["scripts/cleanup.sh"]
  }

}
