
variable "iso_checksum" {
  type    = string
  default = ""
}

variable "iso_url" {
  type    = string
  default = "C:/Your/File/Path/File.iso"
}

source "virtualbox-iso" "vbox" {
  communicator      = "winrm"
  disk_size         = 61440
  cpus              = "2"
  memory            = "2048"
  floppy_files      = ["Autounattend.xml", "update-windows.ps1", "configure-winrm.ps1"]
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
    scripts = ["enable-rdp.ps1", "disable-hibernate.ps1", "disable-autologin.ps1", "enable-uac.ps1", "no-expiration.ps1", "enable-ssh.ps1"]
  }

  provisioner "windows-restart" {
    restart_check_command = "powershell -command \"& {if ((get-content C:\\ProgramData\\lastboot.txt) -eq (Get-WmiObject win32_operatingsystem).LastBootUpTime) {Write-Output 'Sleeping for 600 seconds to wait for reboot'; start-sleep 600} else {Write-Output 'Reboot complete'}}\""
    restart_command       = "powershell \"& {(Get-WmiObject win32_operatingsystem).LastBootUpTime > C:\\ProgramData\\lastboot.txt; Restart-Computer -force}\""
  }
}
