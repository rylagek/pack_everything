
variable "iso_checksum" {
  type    = string
  #default = "7f6538f0eb33c30f0a5cbbf2f39973d4c8dea0d64f69bd18e406012f17a8234f" #checksum doesn't match microsoft website iso
  default = "6D3184C31DB662762D9F7174F2F3AD1FCA50B145F6B6815DEBF303216A616A12"
}

variable "iso_url" {
  type    = string
  default = "./Windows.iso" # Must have local copy in directory
}

variable "winrm_username" {
  type    = string
  default = "Administrator"
}

variable "winrm_password" {
  type    = string
  default = "M@dDucc456"
}

variable "winrm_timeout" {
  type    = string
  default = "300m"
}

source "virtualbox-iso" "vbox" {
  communicator   = "winrm"
  disk_size      = 61440
  cpus           = "2"
  memory         = "2048"
  winrm_password = "${var.winrm_password}"
  winrm_username = "${var.winrm_username}"
  winrm_timeout  = "${var.winrm_timeout}"
  floppy_files = [
    "Autounattend.xml",
    "enable-admin.ps1",
    "enable-winrm.ps1",
  ]
  headless                = false
  iso_checksum            = "sha256:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  shutdown_command        = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  guest_os_type           = "Windows10_64"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--clipboard-mode", "bidirectional"], ["modifyvm", "{{ .Name }}", "--draganddrop", "bidirectional"]]
  virtualbox_version_file = ""
}

build {
  sources = ["source.virtualbox-iso.vbox"]

  provisioner "powershell" {
    elevated_user     = "SYSTEM"
    elevated_password = ""
    scripts           = ["update-windows.ps1"]
  }

  provisioner "windows-restart" {
    restart_check_command = "powershell -command \"& {if ((get-content C:\\ProgramData\\lastboot.txt) -eq (Get-WmiObject win32_operatingsystem).LastBootUpTime) {Write-Output 'Sleeping for 600 seconds to wait for reboot'; start-sleep 600} else {Write-Output 'Reboot complete'}}\""
    restart_command       = "powershell \"& {(Get-WmiObject win32_operatingsystem).LastBootUpTime > C:\\ProgramData\\lastboot.txt; Restart-Computer -force}\""
  }

  provisioner "powershell" {
    scripts = [
      "enable-rdp.ps1",
      "disable-hibernate.ps1",
      "disable-autologin.ps1",
      "enable-uac.ps1",
      "no-expiration.ps1"
    ]
  }

  provisioner "windows-restart" {
    restart_check_command = "powershell -command \"& {if ((get-content C:\\ProgramData\\lastboot.txt) -eq (Get-WmiObject win32_operatingsystem).LastBootUpTime) {Write-Output 'Sleeping for 600 seconds to wait for reboot'; start-sleep 600} else {Write-Output 'Reboot complete'}}\""
    restart_command       = "powershell \"& {(Get-WmiObject win32_operatingsystem).LastBootUpTime > C:\\ProgramData\\lastboot.txt; Restart-Computer -force}\""
  }
}
