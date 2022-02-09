variable "iso_checksum" {
  type    = string
  default = "cdcbee6b1fdfb4caf6c9f80ccadc161366ec337746e8394bf4454faa2fc11aa1"
}

variable "iso_urls" {
  type = list(string)
  default = [
    "securityonion-2.3.100-20220131.iso",
    "https://download.securityonion.net/file/securityonion/securityonion-2.3.100-20220131.iso"
  ]
}
variable "ssh_username" {
  type    = string
  default = "packer"
}

variable "ssh_password" {
  type    = string
  default = "automation"
}
source "virtualbox-iso" "so-step-01" {
  boot_command         = ["<esc><wait>", "vmlinuz initrd=initrd.img inst.stage2=hd:LABEL=CentOS\\x207\\x20x86_64 <wait>", "ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg nomodeset quiet", "<enter>"]
  cpus                 = "4"
  guest_additions_mode = "disable"
  guest_os_type        = "Ubuntu_64"
  http_directory       = "http"
  iso_checksum         = "sha256:${var.iso_checksum}"
  iso_urls             = "${var.iso_urls}"
  memory               = "13000"
  disk_size            = "150000"
  shutdown_command     = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  ssh_password         = "automation"
  ssh_timeout          = "60m"
  ssh_username         = "packer"
  vm_name              = "so-step-01"
  vboxmanage = [
    ["modifyvm", "{{ .Name }}", "--clipboard-mode", "bidirectional"],
    ["modifyvm", "{{ .Name }}", "--draganddrop", "bidirectional"],
    ["modifyvm", "{{ .Name }}", "--nic2", "null"],
  ]
  virtualbox_version_file = ""
}

source "virtualbox-ovf" "so-step-02" {
  source_path      = "output-so-step-01/so-step-01.ovf"
  ssh_username     = "${var.ssh_username}"
  ssh_password     = "${var.ssh_password}"
  shutdown_command = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
}

# Build the base image
build {
  name    = "security-onion-base"
  sources = ["source.virtualbox-iso.so-step-01"]
}

#Build an image of an eval install
build {
  name = "security-onion-eval"
  source "virtualbox-ovf.so-step-02" {
    vm_name = "so-eval"
  }
  provisioner "file" {
    source      = "scripts/ucwt-eval-iso"
    destination = "/home/${var.ssh_username}/SecurityOnion/setup/automation/ucwt-iso"
  }
  provisioner "shell" {
    execute_command   = "echo '{$var.ssh_password}' | {{ .Vars }} sudo -S bash -euxo pipefail '{{ .Path }}'"
    scripts           = ["scripts/install.sh", ]
    expect_disconnect = true
    pause_after       = "10s"
  }
}

#Build an image of a standalone install
build {
  name = "security-onion-standalone"
  source "virtualbox-ovf.so-step-02" {
    vm_name = "so-standalone"
  }
  provisioner "file" {
    source      = "scripts/ucwt-standalone-iso"
    destination = "/home/${var.ssh_username}/SecurityOnion/setup/automation/ucwt-iso"
  }
  provisioner "shell" {
    execute_command   = "echo '{$var.ssh_password}' | {{ .Vars }} sudo -S bash -euxo pipefail '{{ .Path }}'"
    scripts           = ["scripts/install.sh", ]
    expect_disconnect = true
    pause_after       = "10s"
  }
}
