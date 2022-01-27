
variable "iso_checksum" {
  type    = string
  default = "7f6538f0eb33c30f0a5cbbf2f39973d4c8dea0d64f69bd18e406012f17a8234f"
}

variable "iso_url" {
  type    = string
  default = "./win10.iso"
}

variable "ssh_username" {
  type    = string
  default = "vbox"
}

variable "ssh_password" {
  type    = string
  default = "packer"
}

variable "ssh_timeout"  {
  type = string
  default = "300m"
}

source "virtualbox-iso" "vbox" {
  communicator      = "ssh"
  disk_size         = 61440
  cpus              = "2"
  memory            = "2048"
  ssh_password      = "${var.ssh_password}"
  ssh_username      = "${var.ssh_username}"
  ssh_timeout       = "${var.ssh_timeout}"
  floppy_files      = [
                         "Autounattend.xml",
                         "configure-winrm.ps1",
                         "enable-ssh.ps1"
                      ]
  headless          = false
  iso_checksum      = "sha256:${var.iso_checksum}"
  iso_url           = "${var.iso_url}"
  shutdown_command  = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  winrm_password    = "vbox"
  winrm_timeout     = "6h"
  winrm_username    = "vbox"
  guest_os_type     = "Windows10_64"
  vboxmanage        = [["modifyvm", "{{ .Name }}", "--clipboard-mode", "bidirectional"], ["modifyvm", "{{ .Name }}", "--draganddrop", "bidirectional"]]
  virtualbox_version_file = ""
}

build {
  sources = ["source.virtualbox-iso.vbox"]

  provisioner "powershell" {
    scripts = [
                 "enable-rdp.ps1",
                 "disable-hibernate.ps1",
                 "disable-autologin.ps1",
                 "enable-uac.ps1",
                 "no-expiration.ps1",
                 "update-windows.ps1"
              ]
  }

  provisioner "windows-restart" {
    restart_check_command = "powershell -command \"& {if ((get-content C:\\ProgramData\\lastboot.txt) -eq (Get-WmiObject win32_operatingsystem).LastBootUpTime) {Write-Output 'Sleeping for 600 seconds to wait for reboot'; start-sleep 600} else {Write-Output 'Reboot complete'}}\""
    restart_command       = "powershell \"& {(Get-WmiObject win32_operatingsystem).LastBootUpTime > C:\\ProgramData\\lastboot.txt; Restart-Computer -force}\""
  }
}
