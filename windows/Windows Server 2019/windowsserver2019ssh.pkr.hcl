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
  default = "549BCA46C055157291BE6C22A3AAAED8330E78EF4382C99EE82C896426A1CEE1"
}

variable "iso_url" {
  type    = string
  default = "C:/Users/alang/OneDrive/Documents/windowsserver2k19/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso"
}

variable "memsize" {
  type    = string
  default = "2048"
}

variable "numvcpus" {
  type    = string
  default = "2"
}

variable "vm_name" {
  type    = string
  default = "Win2019_17763-Core"
}

variable "ssh_password" {
  type    = string
  default = "vbox"
}

variable "ssh_username" {
  type    = string
  default = "Administrator"
}

source "virtualbox-iso" "autogenerated_1" {
  boot_wait            = "${var.boot_wait}"
  communicator         = "ssh"
  disk_size            = "${var.disk_size}"
  floppy_files         = ["C:/Users/alang/OneDrive/Documents/windowsserver2k19/autounattend.xml"]
  guest_additions_mode = "disable"
  guest_os_type        = "Windows2016_64"
  headless             = false
  iso_checksum         = "sha256:${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  shutdown_command     = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout     = "30m"
  vboxmanage           = [["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"]]
  vm_name              = "${var.vm_name}"
  ssh_password       = "${var.ssh_password}"
  ssh_timeout        = "4h"
  ssh_username       = "${var.ssh_username}"
}

source "vmware-iso" "autogenerated_2" {
  boot_wait        = "${var.boot_wait}"
  communicator     = "ssh"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  floppy_files     = ["C:/Users/alang/OneDrive/Documents/windowsserver2k19/autounattend.xml"]
  guest_os_type    = "windows9srv-64"
  headless         = false
  iso_checksum     = "sha256:${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  shutdown_command = "shutdown /s /t 5 /f /d p:4:1 /c \"Packer Shutdown\""
  shutdown_timeout = "30m"
  skip_compaction  = false
  vm_name          = "${var.vm_name}"
  vmx_data = {
    memsize             = "${var.memsize}"
    numvcpus            = "${var.numvcpus}"
    "scsi0.virtualDev"  = "lsisas1068"
    "virtualHW.version" = "14"
  }
  ssh_password = "${var.ssh_password}"
  ssh_timeout  = "4h"
  ssh_username = "${var.ssh_username}"
}

build {
  sources = ["source.virtualbox-iso.autogenerated_1"]

 

  provisioner "powershell" {
    only         = ["virtualbox-iso"]
    pause_before = "1m0s"
    scripts      = ["C:/Users/alang/OneDrive/Documents/windowsserver2k19/virtualbox-guest-additions.ps1"]
  }

  provisioner "powershell" {
    scripts = ["C:/Users/alang/OneDrive/Documents/windowsserver2k19/setup.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    scripts = ["C:/Users/alang/OneDrive/Documents/windowsserver2k19/win-update.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    scripts = ["C:/Users/alang/OneDrive/Documents/windowsserver2k19/win-update.ps1"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }

  provisioner "powershell" {
    pause_before = "1m0s"
    scripts      = ["C:/Users/alang/OneDrive/Documents/windowsserver2k19/cleanup.ps1"]
  }

  provisioner "powershell" {
    scripts = ["C:/Users/alang/OneDrive/Documents/windowsserver2k19/sshstarter.ps1"]
  }

}
